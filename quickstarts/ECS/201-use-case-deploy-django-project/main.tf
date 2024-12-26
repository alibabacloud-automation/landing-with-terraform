provider "alicloud" {
  region = var.region
}

variable "region" {
  default = "cn-chengdu"
}

variable "ecs_instance_id" {
  description = "ECS instance ID if using an existing instance. Note: This one-click deployment script only supports Alibaba Cloud Linux 3, please do not select instances of other operating systems."
  type        = string
  default     = ""
}

variable "common_name" {
  description = "Common name for resources."
  type        = string
  default     = "deploy_django_by_tf"
}

variable "instance_password" {
  description = "Server login password, length 8-30, must contain three (Capital letters, lowercase letters, numbers, `~!@#$%^&*_-+=|{}[]:;'<>?,./ Special symbol in)"
  type        = string
  default     = "Test@123456"
}

variable "image_id" {
  description = "Image of instance."
  type        = string
  default     = "aliyun_3_x64_20G_alibase_20240528.vhd"
}

variable "instance_type" {
  description = "Instance type."
  type        = string
  default     = "ecs.e-c1m2.large"
}

# 查询满足条件的可用区
data "alicloud_zones" "default" {
  available_disk_category     = "cloud_essd"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.instance_type
}

resource "alicloud_vpc" "django_vpc" {
  count      = local.create_instance ? 1 : 0
  vpc_name   = "${var.common_name}-vpc"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "django_vsw" {
  count        = local.create_instance ? 1 : 0
  vpc_id       = alicloud_vpc.django_vpc[0].id
  vswitch_name = "${var.common_name}-vsw"
  cidr_block   = "192.168.0.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "django_sg" {
  security_group_name = "${var.common_name}-sg"
  vpc_id              = local.vpc_id
}

resource "alicloud_security_group_rule" "allow_tcp_22" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.django_sg.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_tcp_80" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.django_sg.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_icmp_all" {
  type              = "ingress"
  ip_protocol       = "icmp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.django_sg.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_instance" "django_ecs" {
  count                      = local.create_instance ? 1 : 0
  availability_zone          = data.alicloud_zones.default.zones.0.id
  security_groups            = alicloud_security_group.django_sg.*.id
  instance_type              = var.instance_type
  system_disk_category       = "cloud_essd"
  image_id                   = var.image_id
  instance_name              = "${var.common_name}-ecs"
  vswitch_id                 = alicloud_vswitch.django_vsw.0.id
  internet_max_bandwidth_out = 100
  password                   = var.instance_password
}

resource "alicloud_ecs_command" "deploy_django" {
  name            = "DeploydJango"
  type            = "RunShellScript"
  command_content = base64encode(local.command_content)
  timeout         = 600
  working_dir     = "/root"
}


resource "alicloud_ecs_invocation" "invocation" {
  instance_id = [local.instanceId]
  command_id  = alicloud_ecs_command.deploy_django.id
  timeouts {
    create = "5m"
  }
}

data "alicloud_instances" "default" {
  count = local.create_instance ? 0 : 1
  ids   = [var.ecs_instance_id]
}

locals {
  create_instance    = var.ecs_instance_id == ""
  instanceId         = local.create_instance ? alicloud_instance.django_ecs[0].id : var.ecs_instance_id
  instance_public_ip = local.create_instance ? element(alicloud_instance.django_ecs.*.public_ip, 0) : lookup(data.alicloud_instances.default[0].instances.0, "public_ip")
  vpc_id             = local.create_instance ? alicloud_vpc.django_vpc[0].id : lookup(data.alicloud_instances.default[0].instances.0, "vpc_id")
  command_content    = <<SHELL
#!/bin/bash
sudo yum -y install nginx python3-devel.x86_64
sudo pip3 install Django uwsgi
sudo mkdir /home/myblog && cd /home/myblog
sudo /usr/local/bin/django-admin.py startproject uwsgi_project
sudo sed -i 's/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \[\"*\"\]/g' /home/myblog/uwsgi_project/uwsgi_project/settings.py
sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
sudo mv /etc/uwsgi.ini /etc/uwsgi.ini.bak
cat << "NGINX" > /etc/nginx/nginx.conf
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;
# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;
events {
    worker_connections 1024;
}
http {
    log_format  main  '$remote_addr - $remote_user [$time_local] \"$request\" '
                      '$status $body_bytes_sent \"$http_referer\" '
                      '\"$http_user_agent\" \"$http_x_forwarded_for\"';
    access_log  /var/log/nginx/access.log  main;
    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 4096;
    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;
    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;
    upstream django {
        server 127.0.0.1:8001; #具体端口必须与您uWSGI配置文件中定义的端口一致
    }
    server {
        listen       80; #设置的nginx访问端口
        server_name  test;
        charset      utf-8;
        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;
        location /static {
            autoindex on;
            alias /home/myblog/uwsgi_project/uwsgi_project/static; #具体目录以您现场具体部署的目录为准
        }
        location / {
            uwsgi_pass 127.0.0.1:8001;
            include uwsgi_params; #具体目录以您现场具体部署的目录为准
            include /etc/nginx/uwsgi_params; #具体目录以您现场具体部署的目录为准
            uwsgi_param UWSGI_SCRIPT iCourse.wsgi; #具体目录以您现场具体部署的目录为准
            uwsgi_param UWSGI_CHDIR /iCourse; #具体目录以您现场具体部署的目录为准
            index  index.html index.htm;
            client_max_body_size 35m;
            index index.html index.htm;
        }
        error_page 404 /404.html;
        location = /40x.html {

        }
        error_page 500 502 503 504 /50x.html;
        location = /50x.html {

        }
    }
}      
NGINX

cat << "UWSGI" > /etc/uwsgi.ini
[uwsgi]
socket = 127.0.0.1:8001
chdir = /home/myblog/uwsgi_project/
wsgi-file = uwsgi_project/wsgi.py
processes = 4
threads = 2
vacuum = true
buffer-size = 65536
UWSGI

cat << "EOF" > /etc/systemd/system/uwsgi.service
[Unit]
Description=uwsgi service
After=network.target
[Service]
Type=simple
User=nginx
Group=nginx
ExecStart=/usr/local/bin/uwsgi --ini /etc/uwsgi.ini
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable nginx.service
sudo systemctl restart nginx.service
sudo systemctl enable uwsgi.service
sudo systemctl restart uwsgi.service
SHELL
}

output "ecs_login_address" {
  value = format("https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=%s&instanceId=%s", var.region, local.instanceId)
}

output "django_url" {
  value = format("http://%s", local.instance_public_ip)
}
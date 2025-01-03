provider "alicloud" {
  region = var.region
}

variable "region" {
  description = "Region where resources will be created"
  default     = "cn-beijing"
}

variable "common_name" {
  default     = "deploy-java-web-by-terraform"
  description = "Common name for resources"
}


variable "system_disk_category" {
  default     = "cloud_essd"
  description = "The category of the system disk."
}

variable "instance_password" {
  default     = "Test@123456"
  description = "Server login password"
}

variable "image_id" {
  default     = "aliyun_3_x64_20G_alibase_20240528.vhd"
  description = "Please choose the Alibaba Cloud Linux 3 Image ID for the instance"
}

variable "instance_type" {
  description = "Instance type"
  default     = "ecs.e-c1m2.large"
}

variable "instance_count" {
  description = "The number of ECS instances to create."
  default     = "2"
}

variable "ecs_ram_role_name" {
  description = "English letters, numbers, or ' - ' are allowed. The number of characters should be less than or equal to 64."
  default     = "EcsRoleForMiniProgramServer"
}

data "alicloud_zones" "default" {
  available_disk_category     = var.system_disk_category
  available_resource_creation = "VSwitch"
  available_instance_type     = var.instance_type
}

resource "alicloud_ram_role" "role" {
  name        = var.ecs_ram_role_name
  document    = <<EOF
  {
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": [
            "ecs.aliyuncs.com"
          ]
        }
      }
    ],
    "Version": "1"
  }
  EOF
  description = "Ecs ram role."
  force       = true
}

resource "alicloud_ram_policy" "policy" {
  policy_name     = "${var.ecs_ram_role_name}Policy"
  policy_document = <<EOF
  {
    "Statement": [
      {
        "Action":  [
          "ecs:DescribeInstances",
          "ecs:DescribeInstanceStatus"
        ],
        "Effect":  "Allow",
        "Resource": ["*"]
      }
    ],
      "Version": "1"
  }
  EOF
  description     = "this is a policy test"
  force           = true
}

resource "alicloud_ram_role_policy_attachment" "attach" {
  policy_name = alicloud_ram_policy.policy.policy_name
  policy_type = "Custom"
  role_name   = alicloud_ram_role.role.name
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "${var.common_name}-vpc"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  vswitch_name = "${var.common_name}-vsw"
  cidr_block   = "192.168.0.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "sg" {
  security_group_name = "${var.common_name}-sg"
  vpc_id              = alicloud_vpc.vpc.id
  description         = "Security group for ECS instance"
}

resource "alicloud_security_group_rule" "allow_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.sg.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_80" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.sg.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_ram_role_attachment" "attach" {
  role_name    = alicloud_ram_role.role.name
  instance_ids = alicloud_instance.ecs_instance.*.id
}

resource "alicloud_instance" "ecs_instance" {
  count                      = var.instance_count
  instance_name              = "${var.common_name}-ecs"
  image_id                   = var.image_id
  instance_type              = var.instance_type
  security_groups            = alicloud_security_group.sg.*.id
  vswitch_id                 = alicloud_vswitch.vswitch.id
  password                   = var.instance_password
  internet_max_bandwidth_out = 100
  system_disk_category       = var.system_disk_category
}

resource "alicloud_eip_address" "eip" {
  description  = "${var.common_name}-eip"
  address_name = "${var.common_name}-eip"
  netmode      = "public"
  bandwidth    = "5"
}

resource "alicloud_eip_association" "clb_ip" {
  allocation_id = alicloud_eip_address.eip.id
  instance_id   = alicloud_slb_load_balancer.instance.id
}

resource "alicloud_slb_load_balancer" "instance" {
  load_balancer_name   = "${var.common_name}-clb"
  load_balancer_spec   = "slb.s2.small"
  internet_charge_type = "PayByTraffic"
  address_type         = "intranet"
  vswitch_id           = alicloud_vswitch.vswitch.id
}

resource "alicloud_slb_listener" "listener" {
  load_balancer_id          = alicloud_slb_load_balancer.instance.id
  backend_port              = 80
  frontend_port             = 80
  protocol                  = "http"
  bandwidth                 = -1
  health_check              = "on"
  health_check_uri          = "/"
  health_check_connect_port = 80
  healthy_threshold         = 3
  unhealthy_threshold       = 3
  health_check_timeout      = 5
  health_check_interval     = 2
  health_check_http_code    = "http_2xx,http_3xx"
}

resource "alicloud_slb_attachment" "default" {
  load_balancer_id = alicloud_slb_load_balancer.instance.id
  instance_ids     = alicloud_instance.ecs_instance.*.id
  weight           = 80
}

resource "alicloud_ecs_command" "deploy" {
  name            = "DeployMiniProgramServer"
  type            = "RunShellScript"
  command_content = base64encode(local.command_content)
  timeout         = 3600
  working_dir     = "/root"
}

resource "alicloud_ecs_invocation" "invocation" {
  instance_id = alicloud_instance.ecs_instance.*.id
  command_id  = alicloud_ecs_command.deploy.id
  timeouts {
    create = "10m"
  }
}

locals {
  command_content = <<EOF
#!/bin/bash
if [ ! -f .tf.provision ]; then
  echo "Name: 搭建小程序" > .tf.provision
fi

name=$(grep "^Name:" .tf.provision | awk -F':' '{print $2}' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

if [ "$name" != "搭建小程序" ]; then
  echo "当前实例已使用过\"$name\"教程的一键配置，不能再使用本教程的一键配置"
  exit 0
fi

if ! grep -q "^Step1: Install Python$" .tf.provision; then
  echo "#########################"
  echo "# Install Python"
  echo "#########################"
  mkdir /data && touch /data/GetServerInfo.py
  cat > /data/GetServerInfo.py << EOF2
# -*- coding: utf-8 -*-
from flask import Flask, jsonify, request
from alibabacloud_credentials.client import Client as CredClient
from alibabacloud_credentials.models import Config as CredConfig
from alibabacloud_ecs20140526 import models as ecs_20140526_models
from alibabacloud_ecs20140526.client import Client as EcsClient
from alibabacloud_tea_openapi.models import Config

app = Flask(__name__)

ecs_ram_role = '${var.ecs_ram_role_name}'
region = '${var.region}'


# 用于健康检查
@app.route('/', methods=['HEAD', 'GET'])
def index():
    return "ok"


# 在app.route装饰器中声明响应的URL和请求方法 Declare the URL and request method of the response in the app.route decorator.
@app.route('/ecs/getServerInfo', methods=['GET'])
def get_server_info():
    cred_config = CredConfig(
        type='ecs_ram_role',
        role_name=ecs_ram_role,
    )
    cred_client = CredClient(cred_config)
    ecs_config = Config(credential=cred_client, region_id=region)
    ecs_client = EcsClient(ecs_config)
    # GET方式获取请求参数 Get request parameters.
    instance_id = request.args.get("instanceId")
    if instance_id is None:
        return "Invalid Parameter"
    instance_ids = [instance_id]
    # 查询实例信息 Query instance information.
    describe_instances_request = ecs_20140526_models.DescribeInstancesRequest()
    describe_instances_request.region_id = region
    describe_instances_request.instance_ids = str(instance_ids)

    describe_instances_response = ecs_client.describe_instances(describe_instances_request)
    # 返回数据为bytes类型，需要将bytes类型转换为str然后反序列化为json对象 The returned data is of type bytes, which needs to be converted to str and then deserialized into a json object.
    if len(describe_instances_response.to_map()['body']['Instances']['Instance']) == 0:
        return jsonify({})

    instance_info = describe_instances_response.to_map()['body']['Instances']['Instance'][0]

    # 查询实例状态 Query instance status.
    describe_instance_status_request = ecs_20140526_models.DescribeInstanceStatusRequest()
    describe_instance_status_request.region_id = region
    describe_instance_status_request.instance_id = instance_ids
    describe_instance_status_response = ecs_client.describe_instance_status(describe_instance_status_request)
    instance_status = describe_instance_status_response.to_map()['body']['InstanceStatuses']['InstanceStatus'][0][
        'Status']

    # 封装结果 result
    result = {
        # cpu数
        'Cpu': instance_info['Cpu'],
        # 内存大小
        'Memory': instance_info['Memory'],
        # 操作系统名称
        'OSName': instance_info['OSName'],
        # 实例规格
        'InstanceType': instance_info['InstanceType'],
        # 实例公网IP地址
        'IpAddress': instance_info['PublicIpAddress']['IpAddress'][0],
        # 公网出带宽最大值
        'InternetMaxBandwidthOut': instance_info['InternetMaxBandwidthOut'],
        # 实例状态
        'instance_status': instance_status
    }
    return jsonify(result)


if __name__ == "__main__":
    app.run()

EOF2
  touch /data/requirements.txt
  cat > /data/requirements.txt << EOF2
wheel
alibabacloud_ecs20140526
Flask==2.0.3

EOF2
  pip3 install --upgrade pip && pip3 install -r /data/requirements.txt
  echo "Step1: Install Python" >> .tf.provision
else
  echo "#########################"
  echo "# Python has been installed"
  echo "#########################"
fi

if ! grep -q "^Step2: Install uWSGI Server$" .tf.provision; then
  echo "#########################"
  echo "# Install uWSGI Server"
  echo "#########################"
  pip3 install uwsgi
  touch /data/uwsgi.ini
  cat > /data/uwsgi.ini << EOF2
[uwsgi]

#uwsgi启动时所使用的地址和端口 The address and port used when uwsgi starts.

socket=127.0.0.1:5000

#指向网站目录 site directory.

chdir=/data


#python启动程序文件 python start file.

wsgi-file=GetServerInfo.py


#python程序内用以启动的application变量名 The application variable name used to start in the python program.

callable=app


#处理器数 Processors.

processes=1


#线程数 Threads.

threads=2


#状态检测地址 status detection address.

stats=127.0.0.1:9191


#保存启动之后主进程的pid Save the pid file of the main process after startup.

pidfile=/data/uwsgi.pid


#设置uwsgi后台运行，uwsgi.log保存日志信息 自动生成 save log info file.

daemonize=/data/uwsgi.log

EOF2
  uwsgi /data/uwsgi.ini
  echo "Step2: Install uWSGI Server" >> .tf.provision
else
  echo "#########################"
  echo "# uWSGI Server has been installed"
  echo "#########################"
fi

if ! grep -q "^Step3: Install Nginx$" .tf.provision; then
  echo "#########################"
  echo "# Install Nginx"
  echo "#########################"
  yum install -y nginx
  touch /etc/nginx/conf.d/app.conf
  cat > /etc/nginx/conf.d/app.conf << EOF2
server {
    listen 80 default_server;
    
    server_name app.example.com;

    root /var/www/html;

    # Add index.php to the list if you are using PHP
    index index.html index.htm index.nginx-debian.html;

    location / {
        # 转发端口 forwarding address.
        uwsgi_pass  127.0.0.1:5000;
        include uwsgi_params;
    }
}

EOF2
  systemctl start nginx
  echo "Step3: Install Nginx" >> .tf.provision
else
  echo "#########################"
  echo "# Nginx has been installed"
  echo "#########################"
fi
EOF
}

output "public_ip" {
  value = alicloud_eip_address.eip.ip_address
}
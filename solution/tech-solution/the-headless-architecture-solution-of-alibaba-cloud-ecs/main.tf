provider "alicloud" {
  region = var.region
}

data "alicloud_zones" "default" {
  available_disk_category     = "cloud_essd"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.instance_type
}

resource "random_string" "suffix" {
  length  = 8
  lower   = true
  upper   = false
  numeric = false
  special = false
}

locals {
  common_name = random_string.suffix.id
}

resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "vpc-${local.common_name}"
}

resource "alicloud_vswitch" "vswitch_1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.1.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = "vswitch-1-${local.common_name}"
}

resource "alicloud_vswitch" "vswitch_2" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.2.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = "vswitch-2-${local.common_name}"
}

resource "alicloud_vswitch" "vswitch_3" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.3.0/24"
  zone_id      = data.alicloud_zones.default.zones.1.id
  vswitch_name = "vswitch-3-${local.common_name}"
}

resource "alicloud_vswitch" "vswitch_4" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.4.0/24"
  zone_id      = data.alicloud_zones.default.zones.1.id
  vswitch_name = "vswitch-4-${local.common_name}"
}

resource "alicloud_security_group" "security_group_frontend" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "sg-fe-${local.common_name}"
}

resource "alicloud_security_group" "security_group_backend" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "sg-be-${local.common_name}"
}

resource "alicloud_security_group_rule" "fe_allow_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.security_group_frontend.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "be_allow_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.security_group_backend.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "fe_allow_nginx" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.security_group_frontend.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "be_allow_tomcat" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "8080/8080"
  priority          = 1
  security_group_id = alicloud_security_group.security_group_backend.id
  cidr_ip           = "0.0.0.0/0"
}

data "alicloud_images" "default" {
  name_regex  = "^aliyun_3_x64_20G_alibase_.*"
  most_recent = true
  owners      = "system"
}

# the 1st ECS instance where the frontend app runs
resource "alicloud_instance" "ecs_instance_fe_1" {
  instance_name              = "ecs-fe-1-${local.common_name}"
  image_id                   = data.alicloud_images.default.images[0].id
  instance_type              = var.instance_type
  system_disk_category       = "cloud_essd"
  security_groups            = [alicloud_security_group.security_group_frontend.id]
  vswitch_id                 = alicloud_vswitch.vswitch_1.id
  password                   = var.ecs_instance_password
  internet_max_bandwidth_out = 5
}

# the 2ns ECS instance where the backend app runs
resource "alicloud_instance" "ecs_instance_be_2" {
  instance_name              = "ecs-be-2-${local.common_name}"
  image_id                   = data.alicloud_images.default.images[0].id
  instance_type              = var.instance_type
  system_disk_category       = "cloud_essd"
  security_groups            = [alicloud_security_group.security_group_backend.id]
  vswitch_id                 = alicloud_vswitch.vswitch_2.id
  password                   = var.ecs_instance_password
  internet_max_bandwidth_out = 5
}

# the 3rd ECS instance where the frontend app runs
resource "alicloud_instance" "ecs_instance_fe_3" {
  instance_name              = "ecs-fe-3-${local.common_name}"
  image_id                   = data.alicloud_images.default.images[0].id
  instance_type              = var.instance_type
  system_disk_category       = "cloud_essd"
  security_groups            = [alicloud_security_group.security_group_frontend.id]
  vswitch_id                 = alicloud_vswitch.vswitch_3.id
  password                   = var.ecs_instance_password
  internet_max_bandwidth_out = 5
}

# the 4th ECS instance where the backend app runs
resource "alicloud_instance" "ecs_instance_be_4" {
  instance_name              = "ecs-be-4-${local.common_name}"
  image_id                   = data.alicloud_images.default.images[0].id
  instance_type              = var.instance_type
  system_disk_category       = "cloud_essd"
  security_groups            = [alicloud_security_group.security_group_backend.id]
  vswitch_id                 = alicloud_vswitch.vswitch_4.id
  password                   = var.ecs_instance_password
  internet_max_bandwidth_out = 5
}

resource "alicloud_ecs_command" "run_command_start_backend" {
  name = "command-start-backend-${local.common_name}"
  command_content = base64encode(<<EOF

# Install and start Java backend
curl -fsSL https://help-static-aliyun-doc.aliyuncs.com/install-script/frontend-backend-separation-architecture/java.sh | sudo bash
EOF
  )
  working_dir = "/root"
  type        = "RunShellScript"
  timeout     = 3600
  depends_on  = [alicloud_instance.ecs_instance_be_2, alicloud_instance.ecs_instance_be_4]
}

resource "alicloud_ecs_invocation" "invoke_script_backend" {
  instance_id = [alicloud_instance.ecs_instance_be_2.id, alicloud_instance.ecs_instance_be_4.id]
  command_id  = alicloud_ecs_command.run_command_start_backend.id
  timeouts {
    create = "15m"
  }
  depends_on = [alicloud_instance.ecs_instance_be_2, alicloud_instance.ecs_instance_be_4]
}

resource "alicloud_ecs_command" "run_command_start_frontend" {
  name = "command-start-frontend-${local.common_name}"
  command_content = base64encode(<<EOF

# Install frontend
sudo yum install -y nginx

# Donwload frontend resources
sudo yum install -y unzip
sudo wget -O $HOME/pages.zip https://help-static-aliyun-doc.aliyuncs.com/install-script/frontend-backend-separation-architecture/pages.zip
sudo unzip -o $HOME/pages.zip 
sudo chmod -R a+rx $HOME/dist/ 
sudo cp -r $HOME/dist/* /usr/share/nginx/html

# Config frontend
cat << EOT > /etc/nginx/nginx.conf
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

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
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

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

    server {
        listen       80;
        listen       [::]:80;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        # 客户端访问具体页面地址时对应的静态资源地址
        location / {
            root /usr/share/nginx/html; 
            index index.html;
        }
        
        # 配置请求转发规则
        location /api/ {
            # proxy_pass  http://${alicloud_instance.ecs_instance_be_2.primary_ip_address}:8080/api/;
            proxy_pass  http://${alicloud_alb_load_balancer.backend_alb.dns_name}:8080/api/;

        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }
}
EOT

# Start frontend
sudo systemctl start nginx
sudo systemctl enable nginx

EOF
  )
  working_dir = "/root"
  type        = "RunShellScript"
  timeout     = 3600
  depends_on  = [alicloud_instance.ecs_instance_be_2, alicloud_instance.ecs_instance_be_4]
}

resource "alicloud_ecs_invocation" "invoke_script_frontend" {
  instance_id = [alicloud_instance.ecs_instance_fe_1.id, alicloud_instance.ecs_instance_fe_3.id]
  command_id  = alicloud_ecs_command.run_command_start_frontend.id
  timeouts {
    create = "15m"
  }
  depends_on = [alicloud_instance.ecs_instance_fe_1, alicloud_instance.ecs_instance_fe_3]
}

resource "alicloud_alb_load_balancer" "backend_alb" {
  load_balancer_name    = "lb-be-${local.common_name}"
  vpc_id                = alicloud_vpc.vpc.id
  address_type          = "Intranet"
  load_balancer_edition = "Basic"
  load_balancer_billing_config {
    pay_type = "PayAsYouGo"
  }
  zone_mappings {
    zone_id    = data.alicloud_zones.default.zones.0.id
    vswitch_id = alicloud_vswitch.vswitch_2.id
  }
  zone_mappings {
    zone_id    = data.alicloud_zones.default.zones.1.id
    vswitch_id = alicloud_vswitch.vswitch_4.id
  }
}

resource "alicloud_alb_server_group" "backend_server_group" {
  server_group_name = "alb-be-server-group-${local.common_name}"
  protocol          = "HTTP"
  vpc_id            = alicloud_vpc.vpc.id
  server_group_type = "Instance"
  sticky_session_config {
    sticky_session_enabled = false
  }
  health_check_config {
    health_check_enabled = false
  }
  servers {
    server_type = "Ecs"
    port        = 8080
    server_id   = alicloud_instance.ecs_instance_be_2.id
    server_ip   = alicloud_instance.ecs_instance_be_2.primary_ip_address
    weight      = 50
  }

  servers {
    server_type = "Ecs"
    port        = 8080
    server_id   = alicloud_instance.ecs_instance_be_4.id
    server_ip   = alicloud_instance.ecs_instance_be_4.primary_ip_address
    weight      = 50
  }
}

resource "alicloud_alb_listener" "backend_listener" {
  load_balancer_id  = alicloud_alb_load_balancer.backend_alb.id
  listener_protocol = "HTTP"
  listener_port     = 8080
  default_actions {
    type = "ForwardGroup"
    forward_group_config {
      server_group_tuples {
        server_group_id = alicloud_alb_server_group.backend_server_group.id
      }
    }
  }
}

resource "alicloud_alb_load_balancer" "frontend_alb" {
  load_balancer_name    = "lb-fe-${local.common_name}"
  vpc_id                = alicloud_vpc.vpc.id
  address_type          = "Internet"
  load_balancer_edition = "Basic"
  load_balancer_billing_config {
    pay_type = "PayAsYouGo"
  }
  zone_mappings {
    zone_id    = data.alicloud_zones.default.zones.0.id
    vswitch_id = alicloud_vswitch.vswitch_1.id
  }
  zone_mappings {
    zone_id    = data.alicloud_zones.default.zones.1.id
    vswitch_id = alicloud_vswitch.vswitch_3.id
  }
}

resource "alicloud_alb_server_group" "frontend_server_group" {
  server_group_name = "alb-fe-server-group-${local.common_name}"
  protocol          = "HTTP"
  vpc_id            = alicloud_vpc.vpc.id
  server_group_type = "Instance"
  sticky_session_config {
    sticky_session_enabled = false
  }
  health_check_config {
    health_check_enabled = false
  }
  servers {
    server_type = "Ecs"
    port        = 80
    server_id   = alicloud_instance.ecs_instance_fe_1.id
    server_ip   = alicloud_instance.ecs_instance_fe_1.primary_ip_address
    weight      = 50
  }
  servers {
    server_type = "Ecs"
    port        = 80
    server_id   = alicloud_instance.ecs_instance_fe_3.id
    server_ip   = alicloud_instance.ecs_instance_fe_3.primary_ip_address
    weight      = 50
  }
}

resource "alicloud_alb_listener" "frontend_listener" {
  load_balancer_id  = alicloud_alb_load_balancer.frontend_alb.id
  listener_protocol = "HTTP"
  listener_port     = 80
  default_actions {
    type = "ForwardGroup"
    forward_group_config {
      server_group_tuples {
        server_group_id = alicloud_alb_server_group.frontend_server_group.id
      }
    }
  }
}

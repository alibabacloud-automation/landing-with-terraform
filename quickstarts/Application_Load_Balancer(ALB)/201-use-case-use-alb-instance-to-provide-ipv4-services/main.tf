variable "region" {
  default = "cn-beijing"
}

# ECS登录密码
variable "ecs_password" {
  type    = string
  default = "Terraform@Example"
}

# 域名(改为您的域名)
variable "host_name" {
  type        = string
  default     = "tf-example.com"
  description = "your domain name"
}

# 主机记录
variable "host_record" {
  type        = string
  default     = "image"
  description = "Host Record,like image"
}

provider "alicloud" {
  region = var.region
}

# 查询支持ALB的可用区
data "alicloud_alb_zones" "example" {}

# 查询支持ECS云盘类型的可用区
data "alicloud_zones" "example" {
  available_resource_creation = "VSwitch"                     // 交换机类型
  available_disk_category     = local.available_disk_category // 云盘类型
}

locals {
  vpc_cidr_block          = "172.16.0.0/16"                              # 专有网络VPC的CIDR
  available_disk_category = "cloud_essd"                                 # 云盘类型
  image_id                = "aliyun_2_1903_x64_20G_alibase_20240628.vhd" # 镜像ID
  ecs_instance_type       = "ecs.e-c1m1.large"                           # ECS实例规格
  master_vsw_cidr_block   = "172.16.0.0/24"                              # master交换机的CIDR
  backup_vsw_cidr_block   = "172.16.2.0/24"                              # backup交换机的CIDR
  # 提取地区交集
  intersection_zones = tolist(setintersection(data.alicloud_alb_zones.example.ids, data.alicloud_zones.example.ids))
  # ECS中部署服务脚本
  master_ecs_command = <<EOS
    yum install -y nginx
    systemctl start nginx.service
    cd /usr/share/nginx/html/
    echo "Hello World ! This is master ECS." > index.html
    EOS
  backup_ecs_command = <<EOS
    yum install -y nginx
    systemctl start nginx.service
    cd /usr/share/nginx/html/
    echo "Hello World ! This is backup ECS." > index.html
    EOS
}

# 随机数，取值${random_integer.example.result}
resource "random_integer" "example" {
  min = 10000
  max = 99999
}

# 专有网络VPC
resource "alicloud_vpc" "example" {
  vpc_name   = "vpc_name_${random_integer.example.result}"
  cidr_block = local.vpc_cidr_block
}

# master交换机
resource "alicloud_vswitch" "master_vswitch" {
  vpc_id       = alicloud_vpc.example.id
  cidr_block   = local.master_vsw_cidr_block
  zone_id      = local.intersection_zones[0]
  vswitch_name = "master_vswitch_test_${random_integer.example.result}"
}

# backup交换机
resource "alicloud_vswitch" "backup_vswitch" {
  vpc_id       = alicloud_vpc.example.id
  cidr_block   = local.backup_vsw_cidr_block
  zone_id      = local.intersection_zones[1]
  vswitch_name = "backup_vswitch_test_${random_integer.example.result}"
}

# 安全组
resource "alicloud_security_group" "example" {
  security_group_name = "security_group_name_${random_integer.example.result}"
  vpc_id              = alicloud_vpc.example.id
}

# 添加允许TCP 80端口入方向流量的规则
resource "alicloud_security_group_rule" "ingress" {
  type              = "ingress"                          # 入方向规则
  ip_protocol       = "tcp"                              # TCP协议
  nic_type          = "intranet"                         # 内网网卡类型（VPC环境）
  policy            = "accept"                           # 允许策略
  port_range        = "80/80"                            # 允许80端口
  priority          = 1                                  # 优先级设置
  security_group_id = alicloud_security_group.example.id # 关联的安全组ID
  cidr_ip           = "10.0.0.0/8"                       # 允许的IP地址范围，示例为10.0.0.0/8
}

# 添加允许TCP 80端口出方向流量的规则
resource "alicloud_security_group_rule" "egress" {
  type              = "egress"                           # 入方向规则
  ip_protocol       = "tcp"                              # TCP协议
  nic_type          = "intranet"                         # 内网网卡类型（VPC环境）
  policy            = "accept"                           # 允许策略
  port_range        = "80/80"                            # 允许80端口
  priority          = 1                                  # 优先级设置
  security_group_id = alicloud_security_group.example.id # 关联的安全组ID
  cidr_ip           = "10.0.0.0/8"                       # 允许的IP地址范围，示例为10.0.0.0/8
}

# mster ECS实例
resource "alicloud_instance" "master_example" {
  availability_zone          = local.intersection_zones[0]
  security_groups            = alicloud_security_group.example.*.id
  instance_type              = local.ecs_instance_type
  system_disk_category       = local.available_disk_category
  system_disk_name           = "master_system_disk_name_${random_integer.example.result}"
  system_disk_description    = "master_system_disk_description_${random_integer.example.result}"
  image_id                   = local.image_id
  instance_name              = "master_instance_name_${random_integer.example.result}"
  vswitch_id                 = alicloud_vswitch.master_vswitch.id
  internet_max_bandwidth_out = 10
  password                   = var.ecs_password
}

# backup ECS实例
resource "alicloud_instance" "backup_example" {
  availability_zone          = local.intersection_zones[1]
  security_groups            = alicloud_security_group.example.*.id
  instance_type              = local.ecs_instance_type
  system_disk_category       = local.available_disk_category
  system_disk_name           = "backup_system_disk_name_${random_integer.example.result}"
  system_disk_description    = "backup_system_disk_description_${random_integer.example.result}"
  image_id                   = local.image_id
  instance_name              = "backup_instance_name_${random_integer.example.result}"
  vswitch_id                 = alicloud_vswitch.backup_vswitch.id
  internet_max_bandwidth_out = 10
  password                   = var.ecs_password
}

# master ECS命令
resource "alicloud_ecs_command" "master_ecs_command" {
  name             = "master_ecs_command_name"
  description      = "master_ecs_command_description"
  enable_parameter = false
  type             = "RunShellScript"
  command_content  = base64encode(local.master_ecs_command)
  timeout          = 3600
  working_dir      = "/root"
  lifecycle {
    ignore_changes = [command_content]
  }
}

# 在master ECS中执行命令
resource "alicloud_ecs_invocation" "master_invocation" {
  instance_id = [alicloud_instance.master_example.id]
  command_id  = alicloud_ecs_command.master_ecs_command.id
  timeouts {
    create = "5m"
  }
}

# backup ECS命令
resource "alicloud_ecs_command" "backup_ecs_command" {
  name             = "backup_ecs_command_name"
  description      = "backup_ecs_command_description"
  enable_parameter = false
  type             = "RunShellScript"
  command_content  = base64encode(local.backup_ecs_command)
  timeout          = 3600
  working_dir      = "/root"
  lifecycle {
    ignore_changes = [command_content]
  }
}

# 在backup ECS中执行命令
resource "alicloud_ecs_invocation" "backup_invocation" {
  instance_id = [alicloud_instance.backup_example.id]
  command_id  = alicloud_ecs_command.backup_ecs_command.id
  timeouts {
    create = "5m"
  }
}

# alb服务器组
resource "alicloud_alb_server_group" "example" {
  protocol          = "HTTP"
  server_group_name = "server_group_name_${random_integer.example.result}"
  vpc_id            = alicloud_vpc.example.id

  servers {
    port        = 80
    server_id   = alicloud_instance.master_example.id
    server_ip   = alicloud_instance.master_example.private_ip
    server_type = "Ecs"
  }

  servers {
    port        = 80
    server_id   = alicloud_instance.backup_example.id
    server_ip   = alicloud_instance.backup_example.private_ip
    server_type = "Ecs"
  }

  sticky_session_config {
    sticky_session_enabled = true
    cookie                 = "cookie_${random_integer.example.result}"
    sticky_session_type    = "Server"
  }

  health_check_config {
    health_check_connect_port = "80"
    health_check_enabled      = true
    health_check_host         = var.host_name
    health_check_codes        = ["http_2xx", "http_3xx", "http_4xx"]
    health_check_http_version = "HTTP1.1"
    health_check_interval     = "2"
    health_check_method       = "HEAD"
    health_check_path         = "/tf-example"
    health_check_protocol     = "HTTP"
    health_check_timeout      = 5
    healthy_threshold         = 3
    unhealthy_threshold       = 3
  }
}

# alb 实例
resource "alicloud_alb_load_balancer" "example" {
  load_balancer_edition  = "Basic"
  load_balancer_name     = "load_balancer_name_${random_integer.example.result}"
  address_type           = "Internet"
  address_ip_version     = "IPv4"
  address_allocated_mode = "Fixed"
  vpc_id                 = alicloud_vpc.example.id
  load_balancer_billing_config {
    pay_type = "PayAsYouGo"
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.master_vswitch.id
    zone_id    = alicloud_vswitch.master_vswitch.zone_id
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.backup_vswitch.id
    zone_id    = alicloud_vswitch.backup_vswitch.zone_id
  }
}

# alb监听
resource "alicloud_alb_listener" "example" {
  listener_protocol = "HTTP"
  listener_port     = 80
  load_balancer_id  = alicloud_alb_load_balancer.example.id
  default_actions {
    type = "ForwardGroup"
    forward_group_config {
      server_group_tuples {
        server_group_id = alicloud_alb_server_group.example.id
      }
    }
  }
}

# 域名解析
resource "alicloud_dns_record" "example" {
  name        = var.host_name
  type        = "CNAME"
  host_record = var.host_record
  value       = alicloud_alb_load_balancer.example.dns_name
  ttl         = 600
}
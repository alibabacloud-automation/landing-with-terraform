
variable "region" {
  default = "cn-hangzhou"
}

provider "alicloud" {
  region = var.region
}

# 是否创建部署在ECS的ipv4服务
variable "create_ecs_service" {
  default     = true
  type        = bool
  description = "Do you want to create a service on ecs"
}

# 服务地址
variable "service_endpoint" {
  type        = string
  default     = null
  description = "your service endpoint"
}

# 域名(改为您的域名)
variable "domain_name" {
  type        = string
  default     = "tf-example.com"
  description = "Change to your domain name"
}

locals {
  available_disk_category = "cloud_essd"
  vpc_cidr_block          = "172.16.0.0/16"
  vsw_cidr_block          = "172.16.0.0/24"
  instance_type           = "ecs.e-c1m1.large"
  image_id                = "aliyun_2_1903_x64_20G_alibase_20240628.vhd"
  password                = "Terraform@Example"
  # ECS中部署服务脚本
  ecs_command = <<EOS
    yum install -y nginx
    systemctl start nginx.service
    cd /usr/share/nginx/html/
    echo "Hello World ! This is  ECS." > index.html
    EOS
}

# 可用区
data "alicloud_zones" "example" {
  available_resource_creation      = "VSwitch"
  available_disk_category          = local.available_disk_category
  available_instance_type          = local.instance_type
  available_slb_address_ip_version = "ipv4"
  available_slb_address_type       = "classic_internet"
}

# 随机数，取值${random_integer.example.result}
resource "random_integer" "example" {
  min = 10000
  max = 99999
}

# 专有网络VPC
resource "alicloud_vpc" "example" {
  count      = var.create_ecs_service ? 1 : 0
  vpc_name   = "vpc_name_${random_integer.example.result}"
  cidr_block = local.vpc_cidr_block
}

# 交换机
resource "alicloud_vswitch" "example" {
  count        = var.create_ecs_service ? 1 : 0
  vpc_id       = alicloud_vpc.example.0.id
  cidr_block   = local.vsw_cidr_block
  zone_id      = data.alicloud_zones.example.zones[0].id
  vswitch_name = "vswitch_test_${random_integer.example.result}"
}

# 安全组
resource "alicloud_security_group" "example" {
  count               = var.create_ecs_service ? 1 : 0
  security_group_name = "security_group_name_${random_integer.example.result}"
  vpc_id              = alicloud_vpc.example.0.id
}

# 添加允许TCP 80端口出方向流量的规则
resource "alicloud_security_group_rule" "egress" {
  count             = var.create_ecs_service ? 1 : 0
  type              = "egress"                             # 入方向规则
  ip_protocol       = "tcp"                                # TCP协议
  nic_type          = "intranet"                           # 内网网卡类型（VPC环境）
  policy            = "accept"                             # 允许策略
  port_range        = "8/80"                               # 允许80端口
  priority          = 1                                    # 优先级设置
  security_group_id = alicloud_security_group.example.0.id # 关联的安全组ID
  cidr_ip           = "10.0.0.0/8"                         # 允许的IP地址范围，示例为10.0.0.0/8
}

# ECS实例
resource "alicloud_instance" "example" {
  count                      = var.create_ecs_service ? 1 : 0
  availability_zone          = data.alicloud_zones.example.zones[0].id
  security_groups            = alicloud_security_group.example.*.id
  instance_type              = local.instance_type
  system_disk_category       = local.available_disk_category
  system_disk_name           = "system_disk_name_${random_integer.example.result}"
  system_disk_description    = "system_disk_description_${random_integer.example.result}"
  image_id                   = local.image_id
  instance_name              = "instance_name_${random_integer.example.result}"
  vswitch_id                 = alicloud_vswitch.example.0.id
  internet_max_bandwidth_out = 10
  password                   = local.password
}

# ECS命令
resource "alicloud_ecs_command" "ecs_command" {
  count            = var.create_ecs_service ? 1 : 0
  name             = "ecs_command_name"
  description      = "ecs_command_description"
  enable_parameter = false
  type             = "RunShellScript"
  command_content  = base64encode(local.ecs_command)
  timeout          = 3600
  working_dir      = "/root"
  lifecycle {
    ignore_changes = [command_content]
  }
}

# 在ECS中执行命令
resource "alicloud_ecs_invocation" "nvocation" {
  count       = var.create_ecs_service ? 1 : 0
  instance_id = [alicloud_instance.example.0.id]
  command_id  = alicloud_ecs_command.ecs_command.0.id
  timeouts {
    create = "5m"
  }
}

# 全球加速实例
resource "alicloud_ga_accelerator" "example" {
  accelerator_name       = "accelerator_name_${random_integer.example.result}"
  bandwidth_billing_type = "CDT"
  payment_type           = "PayAsYouGo"
  duration               = 1
  auto_use_coupon        = true
}

data "alicloud_ga_accelerators" "example" {
  ids = [alicloud_ga_accelerator.example.id]
}

# 加速区域
resource "alicloud_ga_ip_set" "example" {
  accelerate_region_id = var.region
  bandwidth            = "5"
  accelerator_id       = alicloud_ga_accelerator.example.id
  ip_version           = "IPv4"
  isp_type             = "BGP"
}

# 监听
resource "alicloud_ga_listener" "example" {
  name           = "listener_name_${random_integer.example.result}"
  accelerator_id = alicloud_ga_accelerator.example.id
  listener_type  = "Standard"
  port_ranges {
    from_port = 80
    to_port   = 80
  }
}

# 终端节点组
resource "alicloud_ga_endpoint_group" "example" {
  accelerator_id = alicloud_ga_accelerator.example.id
  endpoint_configurations {
    endpoint = var.create_ecs_service ? alicloud_instance.example.0.public_ip : var.service_endpoint
    type     = "PublicIp"
    weight   = "20"
  }
  endpoint_group_region = var.region
  listener_id           = alicloud_ga_listener.example.id
}

# 域名解析
resource "alicloud_alidns_record" "example" {
  domain_name = var.domain_name
  type        = "CNAME"
  rr          = "@"
  value       = data.alicloud_ga_accelerators.example.accelerators[0].dns_name
  ttl         = 600
}
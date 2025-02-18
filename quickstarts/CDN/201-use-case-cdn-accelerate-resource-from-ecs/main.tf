variable "region" {
  default = "cn-beijing"
}

# 域名(改为您的域名)
variable "domain_name" {
  default     = "tf-example.com"
  description = "your domain name"
}

# 主机记录
variable "host_name" {
  type        = string
  default     = "image"
  description = "Host Record,like image"
}

# 是否创建ECS
variable "creater_ecs" {
  default     = true
  type        = bool
  description = "Do you want to create a ECS instance"
}

# 已有ECS地址
variable "existed_ecs_ip" {
  default     = ""
  type        = string
  description = "The ip of your existed ecs "
}

locals {
  available_disk_category = "cloud_essd"
  vpc_cidr_block          = "172.16.0.0/16"
  vsw_cidr_block          = "172.16.0.0/24"
  instance_type           = "ecs.e-c1m1.large"
  image_id                = "win2022_21H2_x64_dtc_en-us_40G_alibase_20241211.vhd"
  password                = "Terraform@Example"
}

provider "alicloud" {
  region = var.region
}

data "alicloud_zones" "default" {
  available_instance_type     = local.instance_type
  available_resource_creation = "VSwitch"
  available_disk_category     = local.available_disk_category
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_vpc" "vpc" {
  count      = var.creater_ecs ? 1 : 0
  vpc_name   = "vpc-test_${random_integer.default.result}"
  cidr_block = local.vpc_cidr_block
}

resource "alicloud_security_group" "group" {
  count               = var.creater_ecs ? 1 : 0
  security_group_name = "tf_test_${random_integer.default.result}"
  vpc_id              = alicloud_vpc.vpc.0.id
}

# 添加允许TCP 80端口入方向流量的规则
resource "alicloud_security_group_rule" "ingress" {
  count             = var.creater_ecs ? 1 : 0
  type              = "ingress"                          # 入方向规则
  ip_protocol       = "tcp"                              # TCP协议
  nic_type          = "intranet"                         # 内网网卡类型（VPC环境）
  policy            = "accept"                           # 允许策略
  port_range        = "80/80"                            # 允许80端口
  priority          = 1                                  # 优先级设置
  security_group_id = alicloud_security_group.group.0.id # 关联的安全组ID
  cidr_ip           = "10.0.0.0/8"                       # 允许的IP地址范围，示例为10.0.0.0/8
}

# 交换机
resource "alicloud_vswitch" "vswitch" {
  count        = var.creater_ecs ? 1 : 0
  vpc_id       = alicloud_vpc.vpc.0.id
  cidr_block   = local.vsw_cidr_block
  zone_id      = data.alicloud_zones.default.zones[0].id
  vswitch_name = "vswitch-test-${random_integer.default.result}"
}

# ECS实例
resource "alicloud_instance" "instance" {
  count                      = var.creater_ecs ? 1 : 0
  availability_zone          = data.alicloud_zones.default.zones[0].id
  security_groups            = alicloud_security_group.group.*.id
  instance_type              = local.instance_type
  system_disk_category       = "cloud_essd"
  system_disk_name           = "test_foo_system_disk_${random_integer.default.result}"
  system_disk_description    = "test_foo_system_disk_description"
  image_id                   = "aliyun_2_1903_x64_20G_alibase_20240628.vhd"
  instance_name              = "test_ecs_${random_integer.default.result}"
  vswitch_id                 = alicloud_vswitch.vswitch.0.id
  internet_max_bandwidth_out = 10
  password                   = "Terraform@Example"
}

# 添加一个加速域名
resource "alicloud_cdn_domain_new" "example" {
  domain_name = format("%s.%s", var.host_name, var.domain_name)
  cdn_type    = "web"
  scope       = "overseas"
  sources {
    content  = var.creater_ecs ? alicloud_instance.instance.0.public_ip : var.existed_ecs_ip
    type     = "ipaddr"
    priority = "20"
    port     = 80
  }
}

# 域名解析
resource "alicloud_alidns_record" "example" {
  domain_name = var.domain_name
  type        = "CNAME"
  rr          = var.host_name
  value       = alicloud_cdn_domain_new.example.cname
  ttl         = 600
}
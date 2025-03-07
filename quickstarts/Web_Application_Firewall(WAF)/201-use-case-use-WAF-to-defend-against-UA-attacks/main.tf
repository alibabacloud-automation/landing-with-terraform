provider "alicloud" {
  region = var.region
}

# 资源将要创建的地域
variable "region" {
  default = "cn-beijing"
}

# ECS登录密码
variable "password" {
  description = "Server login password, length 8-30, must contain three (Capital letters, lowercase letters, numbers, `~!@#$%^&*_-+=|{}[]:;'<>?,./ Special symbol in)"
  type        = string
  default     = "Terraform@Example"
}

# 云盘类型
variable "system_disk_category" {
  description = "The category of the system disk."
  type        = string
  default     = "cloud_essd"
}

# ECS系统镜像
variable "image_id" {
  description = "Image of instance. "
  type        = string
  default     = "aliyun_3_x64_20G_alibase_20250117.vhd"
}

# ECS实例规格
variable "instance_type" {
  description = "Instance type."
  type        = string
  default     = "ecs.e-c1m1.large"
}

# 专有网络VPC网段
variable "vpc_cidr_block" {
  type    = string
  default = "172.16.0.0/16"
}

# 交换机VSwitch网段
variable "vswitch_cidr_block" {
  type    = string
  default = "172.16.0.0/24"
}

# source_ip
variable "source_ip" {
  description = "The IP address you used to access the ECS."
  type        = string
  default     = "0.0.0.0/0"
}

# ECS公网带宽
variable "internet_bandwidth" {
  description = "The maximum outbound public bandwidth. Unit: Mbit/s. Valid values: 0 to 100."
  default     = "10"
}

# 可用区
data "alicloud_zones" "example" {
  available_resource_creation = "VSwitch"
  available_disk_category     = var.system_disk_category
  available_instance_type     = var.instance_type
}

# 随机数，取值${random_integer.example.result}
resource "random_integer" "example" {
  min = 10000
  max = 99999
}

# 专有网络VPC
resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc_tf_${random_integer.example.result}"
  cidr_block = var.vpc_cidr_block
}

# 交换机VSwitch
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.vswitch_cidr_block
  zone_id      = data.alicloud_zones.example.zones[0].id
  vswitch_name = "vswitch_tf_${random_integer.example.result}"
}

# 安全组
resource "alicloud_security_group" "example" {
  security_group_name = "security_group_name_${random_integer.example.result}"
  vpc_id              = alicloud_vpc.vpc.id
}

# 添加允许TCP 22端口入方向流量的规则
resource "alicloud_security_group_rule" "allow_tcp_22" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.example.id
  cidr_ip           = var.source_ip
}

# 添加允许TCP 80端口入方向流量的规则
resource "alicloud_security_group_rule" "allow_tcp_80" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.example.id
  cidr_ip           = var.source_ip
}

# 添加允许TCP 443端口入方向流量的规则
resource "alicloud_security_group_rule" "allow_tcp_443" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "443/443"
  priority          = 1
  security_group_id = alicloud_security_group.example.id
  cidr_ip           = var.source_ip
}

# ECS实例
resource "alicloud_instance" "instance" {
  availability_zone          = data.alicloud_zones.example.zones[0].id
  security_groups            = alicloud_security_group.example.*.id
  instance_type              = var.instance_type
  system_disk_category       = var.system_disk_category
  image_id                   = var.image_id
  instance_name              = "instance_tf_${random_integer.example.result}"
  vswitch_id                 = alicloud_vswitch.vswitch.id
  internet_max_bandwidth_out = var.internet_bandwidth
  password                   = var.password
}

# clb 实例
resource "alicloud_slb_load_balancer" "example" {
  load_balancer_name   = "clb_tf_${random_integer.example.result}"
  load_balancer_spec   = "slb.s2.small"
  address_type         = "internet"
  address_ip_version   = "ipv4"
  vswitch_id           = alicloud_vswitch.vswitch.id
  instance_charge_type = "PayBySpec"
}

resource "time_sleep" "example" {
  depends_on      = [alicloud_slb_load_balancer.example]
  create_duration = "30s"
}

# 创建监听
resource "alicloud_slb_listener" "example" {
  load_balancer_id = alicloud_slb_load_balancer.example.id
  server_group_id  = alicloud_slb_server_group.example.id
  backend_port     = 80
  frontend_port    = 80
  protocol         = "http"
  bandwidth        = 10
}

# clb 服务器组
resource "alicloud_slb_server_group" "example" {
  load_balancer_id = alicloud_slb_load_balancer.example.id
  name             = "clb_server_group_tf_${random_integer.example.result}"
}

# 服务器组添加ECS
resource "alicloud_slb_server_group_server_attachment" "default" {
  depends_on      = [time_sleep.example]
  server_group_id = alicloud_slb_server_group.example.id
  server_id       = alicloud_instance.instance.id
  port            = 80
  weight          = 100
  type            = "ecs"
}





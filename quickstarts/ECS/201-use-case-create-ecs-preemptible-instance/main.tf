provider "alicloud" {
  region = var.region
}

# 区域
variable "region" {
  type    = string
  default = "cn-beijing"
}

# VPC 名称
variable "vpc_name" {
  type    = string
  default = "tf_test_fofo"
}

# VPC CIDR 块
variable "vpc_cidr_block" {
  type    = string
  default = "172.16.0.0/12"
}

# VSwitch CIDR 块
variable "vswitch_cidr_block" {
  type    = string
  default = "172.16.0.0/21"
}

# 可用区
variable "availability_zone" {
  type    = string
  default = "cn-beijing-b"
}

# 安全组名称
variable "security_group_name" {
  type    = string
  default = "default"
}

# 实例规格
variable "instance_type" {
  type    = string
  default = "ecs.n2.small"
}

# 系统盘类型
variable "system_disk_category" {
  type    = string
  default = "cloud_efficiency"
}

# 操作系统镜像
variable "image_id" {
  type    = string
  default = "ubuntu_140405_64_40G_cloudinit_20161115.vhd"
}

# 实例名称
variable "instance_name" {
  type    = string
  default = "test_fofo"
}

# 公网带宽
variable "internet_max_bandwidth_out" {
  type    = number
  default = 10
}

# 付费类型
variable "instance_charge_type" {
  type    = string
  default = "PostPaid"
}

# 抢占式实例出价策略
variable "spot_strategy" {
  type    = string
  default = "SpotAsPriceGo"
}

# 抢占式实例的保留时长
variable "spot_duration" {
  type    = number
  default = 0
}

# 入站规则端口范围
variable "port_range" {
  type    = string
  default = "1/65535"
}

# 入站规则优先级
variable "priority" {
  type    = number
  default = 1
}

# 入站规则CIDR
variable "cidr_ip" {
  type    = string
  default = "0.0.0.0/0"
}

resource "alicloud_vpc" "vpc" {
  name       = var.vpc_name
  cidr_block = var.vpc_cidr_block
}

resource "alicloud_vswitch" "vsw" {
  vpc_id            = alicloud_vpc.vpc.id
  cidr_block        = var.vswitch_cidr_block
  availability_zone = var.availability_zone
}

resource "alicloud_security_group" "default" {
  name   = var.security_group_name
  vpc_id = alicloud_vpc.vpc.id
}

resource "alicloud_instance" "instance" {
  availability_zone          = var.availability_zone
  security_groups            = [alicloud_security_group.default.id]
  instance_type              = var.instance_type
  system_disk_category       = var.system_disk_category
  image_id                   = var.image_id
  instance_name              = var.instance_name
  vswitch_id                 = alicloud_vswitch.vsw.id
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  instance_charge_type       = var.instance_charge_type
  spot_strategy              = var.spot_strategy
  spot_duration              = var.spot_duration
}

resource "alicloud_security_group_rule" "allow_all_tcp" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = var.port_range
  priority          = var.priority
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = var.cidr_ip
}
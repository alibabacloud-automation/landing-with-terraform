provider "alicloud" {
  region = var.region_id
}

variable "region_id" {
  default = "cn-shanghai"
}

variable "available_disk_category" {
  default = "cloud_efficiency"
}
variable "available_resource_creation" {
  default = "VSwitch"
}
variable "vpc_name" {
  default = "tf_test_fofo"
}
variable "vpc_cidr_block" {
  default = "172.16.0.0/12"
}
variable "vswitch_cidr_block" {
  default = "172.16.0.0/21"
}
variable "security_group_name" {
  default = "default"
}
variable "instance_type" {
  default = "ecs.n4.large"
}
variable "image_id" {
  default = "ubuntu_18_04_64_20G_alibase_20190624.vhd"
}
variable "instance_name" {
  default = "test_fofo"
}
variable "internet_max_bandwidth_out" {
  default = 10
}
variable "port_range" {
  default = "1/65535"
}
variable "priority" {
  default = 1
}
variable "cidr_ip" {
  default = "0.0.0.0/0"
}

data "alicloud_zones" "default" {
  available_disk_category     = var.available_disk_category
  available_resource_creation = var.available_resource_creation
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = var.vpc_name
  cidr_block = var.vpc_cidr_block
}

resource "alicloud_vswitch" "vsw" {
  vpc_id     = alicloud_vpc.vpc.id
  cidr_block = var.vswitch_cidr_block
  zone_id    = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "default" {
  name   = var.security_group_name
  vpc_id = alicloud_vpc.vpc.id
}

resource "alicloud_instance" "instance" {
  availability_zone          = data.alicloud_zones.default.zones.0.id
  security_groups            = [alicloud_security_group.default.id]
  instance_type              = var.instance_type
  system_disk_category       = var.available_disk_category
  image_id                   = var.image_id
  instance_name              = var.instance_name
  vswitch_id                 = alicloud_vswitch.vsw.id
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
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
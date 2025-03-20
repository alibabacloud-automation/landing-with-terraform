provider "alicloud" {
  region = var.region
}

# 资源将要创建的地域
variable "region" {
  default     = "cn-beijing"
  description = "The region where the resources will be created."
}

# 输入已有的VPC ID，当为已有ECS实例绑定弹性网卡时，该值必填，且值为ECS实例所对应的VPC。
variable "vpc_id" {
  default     = ""
  description = "When binding an ENI to an existing ECS instance, this value is required and must be the VPC associated with the ECS instance."
}

# 指定VPC的CIDR块，当填入vpc_id时，该值可不填。
variable "vpc_cidr_block" {
  default     = "192.168.0.0/16"
  description = "Specify the CIDR block of the VPC. If the vpc_id is provided, this value can be left blank."
}

# 输入可用区，当为已有ECS实例绑定弹性网卡时，该值必填，且值为ECS实例所在可用区。
variable "zone_id" {
  default     = ""
  description = "When binding an ENI to an existing ECS instance, this value is required and must be the zone where the ECS instance is located."
}

# 指定VSwitch的CIDR块，CIDR块需在VPC CIDR块的范围内
variable "vswitch_cidr_block" {
  default     = "192.168.0.0/24"
  description = "Specify the CIDR block of the VSwitch. The CIDR block must be within the range of the VPC CIDR block."
}

# 访问弹性网卡的源地址
variable "source_ip" {
  description = "The IP address you used to access the ENI."
  type        = string
  default     = "0.0.0.0/0"
}

# 指定弹性网卡的私网IP地址
variable "private_ip" {
  description = "The primary private IP address of the ENI. The specified IP address must be available within the CIDR block of the VSwitch. If this parameter is not specified, an available IP address is assigned from the VSwitch CIDR block at random."
  type        = string
  default     = ""
}

locals {
  new_zone_id = var.zone_id == ""
  create_vpc  = var.vpc_id == ""
}

resource "alicloud_eip" "eip" {
  address_name = "test_eip"
}

resource "alicloud_vpc" "vpc" {
  count      = local.create_vpc ? 1 : 0
  vpc_name   = "test_vpc"
  cidr_block = var.vpc_cidr_block
}

data "alicloud_zones" "default" {
  count                       = local.new_zone_id ? 1 : 0
  available_resource_creation = "VSwitch"
}

resource "alicloud_vswitch" "vswitch" {
  vswitch_name = "test_vswitch"
  cidr_block   = var.vswitch_cidr_block
  zone_id      = local.new_zone_id ? data.alicloud_zones.default[0].zones.0.id : var.zone_id
  vpc_id       = local.create_vpc ? alicloud_vpc.vpc[0].id : var.vpc_id
}

resource "alicloud_security_group" "group" {
  security_group_name = "test_sg"
  vpc_id              = local.create_vpc ? alicloud_vpc.vpc[0].id : var.vpc_id
}

# 添加允许TCP 80端口入方向流量的规则
resource "alicloud_security_group_rule" "allow_80_tcp" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = var.source_ip
}

resource "alicloud_network_interface" "default" {
  network_interface_name             = "test_eni"
  vswitch_id                         = alicloud_vswitch.vswitch.id
  security_group_ids                 = [alicloud_security_group.group.id]
  primary_ip_address                 = var.private_ip
  secondary_private_ip_address_count = 1
}

resource "alicloud_eip_association" "default" {
  allocation_id = alicloud_eip.eip.id
  instance_type = "NetworkInterface"
  instance_id   = alicloud_network_interface.default.id
}
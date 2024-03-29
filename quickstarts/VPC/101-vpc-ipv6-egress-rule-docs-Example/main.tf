variable "name" {
  default = "terraform-example"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}
data "alicloud_instance_types" "default" {
  availability_zone                 = data.alicloud_zones.default.zones.0.id
  system_disk_category              = "cloud_efficiency"
  cpu_core_count                    = 4
  minimum_eni_ipv6_address_quantity = 1
}
data "alicloud_images" "default" {
  name_regex  = "^ubuntu_18.*64"
  most_recent = true
  owners      = "system"
}

resource "alicloud_vpc" "default" {
  vpc_name    = var.name
  enable_ipv6 = "true"
  cidr_block  = "172.16.0.0/12"
}

resource "alicloud_vswitch" "default" {
  vpc_id               = alicloud_vpc.default.id
  cidr_block           = "172.16.0.0/21"
  zone_id              = data.alicloud_zones.default.zones.0.id
  vswitch_name         = var.name
  ipv6_cidr_block_mask = "64"
}

resource "alicloud_security_group" "default" {
  name        = var.name
  description = var.name
  vpc_id      = alicloud_vpc.default.id
}

resource "alicloud_instance" "default" {
  availability_zone          = data.alicloud_zones.default.zones.0.id
  ipv6_address_count         = 1
  instance_type              = data.alicloud_instance_types.default.instance_types.0.id
  system_disk_category       = "cloud_efficiency"
  image_id                   = data.alicloud_images.default.images.0.id
  instance_name              = var.name
  vswitch_id                 = alicloud_vswitch.default.id
  internet_max_bandwidth_out = 10
  security_groups            = [alicloud_security_group.default.id]
}

resource "alicloud_vpc_ipv6_gateway" "default" {
  ipv6_gateway_name = var.name
  vpc_id            = alicloud_vpc.default.id
}

data "alicloud_vpc_ipv6_addresses" "default" {
  associated_instance_id = alicloud_instance.default.id
  status                 = "Available"
}

resource "alicloud_vpc_ipv6_internet_bandwidth" "default" {
  ipv6_address_id      = data.alicloud_vpc_ipv6_addresses.default.addresses.0.id
  ipv6_gateway_id      = alicloud_vpc_ipv6_gateway.default.ipv6_gateway_id
  internet_charge_type = "PayByBandwidth"
  bandwidth            = "20"
}

resource "alicloud_vpc_ipv6_egress_rule" "default" {
  instance_id           = alicloud_vpc_ipv6_internet_bandwidth.default.ipv6_address_id
  ipv6_egress_rule_name = var.name
  description           = var.name
  ipv6_gateway_id       = alicloud_vpc_ipv6_internet_bandwidth.default.ipv6_gateway_id
  instance_type         = "Ipv6Address"
}
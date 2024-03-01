variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_resource_manager_resource_groups" "default" {}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "vpc" {
  ipv6_isp    = "BGP"
  cidr_block  = "172.168.0.0/16"
  enable_ipv6 = true
  vpc_name    = var.name

}

resource "alicloud_vswitch" "vswich" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "172.168.0.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = var.name

  ipv6_cidr_block_mask = "1"
}


resource "alicloud_vpc_ipv6_address" "default" {
  resource_group_id        = data.alicloud_resource_manager_resource_groups.default.ids.0
  vswitch_id               = alicloud_vswitch.vswich.id
  ipv6_address_description = "create_description"
  ipv6_address_name        = var.name

}
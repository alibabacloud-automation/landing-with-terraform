data "alicloud_zones" "foo" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "foo" {
  vpc_name   = "terraform-example"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vpc_ipv4_cidr_block" "foo" {
  vpc_id               = alicloud_vpc.foo.id
  secondary_cidr_block = "192.163.0.0/16"
}

resource "alicloud_vswitch" "foo" {
  vpc_id     = alicloud_vpc_ipv4_cidr_block.foo.vpc_id
  cidr_block = "192.163.0.0/24"
  zone_id    = data.alicloud_zones.foo.zones.0.id
}
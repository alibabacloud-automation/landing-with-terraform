data "alicloud_zones" "foo" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "terraform-example"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vpc_ipv4_cidr_block" "cidr_blocks" {
  vpc_id               = alicloud_vpc.vpc.id
  secondary_cidr_block = "192.163.0.0/16"
}

resource "alicloud_vswitch" "island-nat" {
  vpc_id       = alicloud_vpc_ipv4_cidr_block.cidr_blocks.vpc_id
  cidr_block   = "172.16.0.0/21"
  zone_id      = data.alicloud_zones.foo.zones.0.id
  vswitch_name = "terraform-example"
  tags = {
    BuiltBy     = "example_value"
    cnm_version = "example_value"
    Environment = "example_value"
    ManagedBy   = "example_value"
  }
}
variable "name" {
  default = "terraform-example"
}

resource "alicloud_vpc" "foo" {
  cidr_block = "172.16.0.0/12"
  name       = var.name
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vswitch" "foo" {
  vpc_id     = alicloud_vpc.foo.id
  cidr_block = "172.16.0.0/21"
  zone_id    = data.alicloud_zones.default.zones[0].id
  name       = var.name
}

resource "alicloud_route_table" "foo" {
  vpc_id           = alicloud_vpc.foo.id
  route_table_name = var.name
  description      = "route_table_attachment"
}

resource "alicloud_route_table_attachment" "foo" {
  vswitch_id     = alicloud_vswitch.foo.id
  route_table_id = alicloud_route_table.foo.id
}
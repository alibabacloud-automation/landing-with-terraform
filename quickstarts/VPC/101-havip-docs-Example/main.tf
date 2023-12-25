variable "name" {
  default = "tf-example"
}
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "example" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_vswitch" "example" {
  vswitch_name = var.name
  cidr_block   = "10.4.0.0/24"
  vpc_id       = alicloud_vpc.example.id
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_havip" "example" {
  vswitch_id  = alicloud_vswitch.example.id
  description = var.name
}
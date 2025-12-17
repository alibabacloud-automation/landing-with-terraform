variable "name" {
  default = "terraform-example"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_vpc" "default" {
  vpc_name   = "${var.name}-${random_integer.default.result}"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "default" {
  zone_id      = data.alicloud_zones.default.zones.0.id
  cidr_block   = "192.168.0.0/16"
  vpc_id       = alicloud_vpc.default.id
  vswitch_name = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_resource_manager_resource_share" "default" {
  resource_share_name = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_resource_manager_shared_resource" "default" {
  resource_share_id = alicloud_resource_manager_resource_share.default.id
  resource_id       = alicloud_vswitch.default.id
  resource_type     = "VSwitch"
}
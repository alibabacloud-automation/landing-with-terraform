variable "name" {
  default = "tf-example"
}
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "defaultVpc" {
  description = var.name
  vpc_name    = var.name
  cidr_block  = "192.168.0.0/16"
}

resource "alicloud_vswitch" "defaultVswitch" {
  vpc_id       = alicloud_vpc.defaultVpc.id
  cidr_block   = "192.168.0.0/21"
  vswitch_name = "${var.name}1"
  zone_id      = data.alicloud_zones.default.zones.0.id
  description  = var.name
}

resource "alicloud_resource_manager_resource_group" "defaultRg" {
  display_name        = "tf-example-defaultRg"
  resource_group_name = "${var.name}2"
}

resource "alicloud_resource_manager_resource_group" "changeRg" {
  display_name        = "tf-example-changeRg"
  resource_group_name = "${var.name}3"
}


resource "alicloud_vpc_ha_vip" "default" {
  description       = var.name
  vswitch_id        = alicloud_vswitch.defaultVswitch.id
  ha_vip_name       = var.name
  ip_address        = "192.168.1.101"
  resource_group_id = alicloud_resource_manager_resource_group.defaultRg.id
}
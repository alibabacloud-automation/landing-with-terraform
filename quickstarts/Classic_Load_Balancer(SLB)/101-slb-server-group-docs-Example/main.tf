variable "slb_server_group_name" {
  default = "forSlbServerGroup"
}

data "alicloud_zones" "server_group" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "server_group" {
  vpc_name   = var.slb_server_group_name
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "server_group" {
  vpc_id       = alicloud_vpc.server_group.id
  cidr_block   = "172.16.0.0/16"
  zone_id      = data.alicloud_zones.server_group.zones[0].id
  vswitch_name = var.slb_server_group_name
}


resource "alicloud_slb_load_balancer" "server_group" {
  load_balancer_name   = var.slb_server_group_name
  vswitch_id           = alicloud_vswitch.server_group.id
  instance_charge_type = "PayByCLCU"
}

resource "alicloud_slb_server_group" "server_group" {
  load_balancer_id = alicloud_slb_load_balancer.server_group.id
  name             = var.slb_server_group_name
}
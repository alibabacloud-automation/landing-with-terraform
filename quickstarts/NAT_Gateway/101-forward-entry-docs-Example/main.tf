variable "name" {
  default = "terraform-example"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "default" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "172.16.0.0/21"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = var.name
}

resource "alicloud_nat_gateway" "default" {
  vpc_id           = alicloud_vpc.default.id
  nat_gateway_name = var.name
  nat_type         = "Enhanced"
  vswitch_id       = alicloud_vswitch.default.id
  network_type     = "intranet"
}

resource "alicloud_vpc_nat_ip" "default" {
  nat_ip         = "172.16.0.66"
  nat_ip_name    = var.name
  nat_gateway_id = alicloud_nat_gateway.default.id
  nat_ip_cidr    = alicloud_vswitch.default.cidr_block
}

resource "alicloud_forward_entry" "default" {
  forward_table_id   = alicloud_nat_gateway.default.forward_table_ids
  external_ip        = alicloud_vpc_nat_ip.default.nat_ip
  external_port      = "80"
  ip_protocol        = "tcp"
  internal_ip        = "172.16.0.115"
  internal_port      = "8080"
  forward_entry_name = var.name
}
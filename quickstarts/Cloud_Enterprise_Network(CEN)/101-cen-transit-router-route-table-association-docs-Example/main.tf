variable "name" {
  default = "terraform-example"
}

locals {
  master_zone = data.alicloud_cen_transit_router_available_resources.default.resources[0].master_zones[0]
  slave_zone  = data.alicloud_cen_transit_router_available_resources.default.resources[0].slave_zones[1]
}

data "alicloud_cen_transit_router_available_resources" "default" {
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "default_master" {
  vswitch_name = var.name
  cidr_block   = "192.168.1.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = local.master_zone
}

resource "alicloud_vswitch" "default_slave" {
  vswitch_name = var.name
  cidr_block   = "192.168.2.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = local.slave_zone
}

resource "alicloud_cen_instance" "default" {
  cen_instance_name = var.name
  protection_level  = "REDUCED"
}

resource "alicloud_cen_transit_router" "default" {
  transit_router_name = var.name
  cen_id              = alicloud_cen_instance.default.id
}

resource "alicloud_cen_transit_router_route_table" "default" {
  transit_router_id = alicloud_cen_transit_router.default.transit_router_id
}

resource "alicloud_cen_transit_router_vpc_attachment" "default" {
  cen_id                                = alicloud_cen_instance.default.id
  transit_router_id                     = alicloud_cen_transit_router.default.transit_router_id
  vpc_id                                = alicloud_vpc.default.id
  transit_router_vpc_attachment_name    = var.name
  transit_router_attachment_description = var.name
  zone_mappings {
    zone_id    = local.master_zone
    vswitch_id = alicloud_vswitch.default_master.id
  }
  zone_mappings {
    zone_id    = local.slave_zone
    vswitch_id = alicloud_vswitch.default_slave.id
  }
}

resource "alicloud_cen_transit_router_route_table_association" "default" {
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.default.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.default.transit_router_attachment_id
}
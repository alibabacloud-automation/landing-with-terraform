variable "name" {
  default = "tf_example"
}

data "alicloud_cen_transit_router_available_resources" "default" {
}

locals {
  zone = data.alicloud_cen_transit_router_available_resources.default.resources[0].master_zones[1]
}

resource "alicloud_vpc" "example" {
  vpc_name   = var.name
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "example" {
  vswitch_name = var.name
  cidr_block   = "192.168.1.0/24"
  vpc_id       = alicloud_vpc.example.id
  zone_id      = local.zone
}

resource "alicloud_security_group" "example" {
  name   = var.name
  vpc_id = alicloud_vpc.example.id
}

resource "alicloud_ecs_network_interface" "example" {
  network_interface_name = var.name
  vswitch_id             = alicloud_vswitch.example.id
  primary_ip_address     = cidrhost(alicloud_vswitch.example.cidr_block, 100)
  security_group_ids     = [alicloud_security_group.example.id]
}

resource "alicloud_cen_instance" "example" {
  cen_instance_name = var.name
}

resource "alicloud_cen_transit_router" "example" {
  transit_router_name = var.name
  cen_id              = alicloud_cen_instance.example.id
  support_multicast   = true
}

resource "alicloud_cen_transit_router_multicast_domain" "example" {
  transit_router_id                    = alicloud_cen_transit_router.example.transit_router_id
  transit_router_multicast_domain_name = var.name
}

resource "alicloud_cen_transit_router_vpc_attachment" "example" {
  cen_id            = alicloud_cen_transit_router.example.cen_id
  transit_router_id = alicloud_cen_transit_router_multicast_domain.example.transit_router_id
  vpc_id            = alicloud_vpc.example.id
  zone_mappings {
    zone_id    = local.zone
    vswitch_id = alicloud_vswitch.example.id
  }
}

resource "alicloud_cen_transit_router_multicast_domain_association" "example" {
  transit_router_multicast_domain_id = alicloud_cen_transit_router_multicast_domain.example.id
  transit_router_attachment_id       = alicloud_cen_transit_router_vpc_attachment.example.transit_router_attachment_id
  vswitch_id                         = alicloud_vswitch.example.id
}

resource "alicloud_cen_transit_router_multicast_domain_member" "example" {
  vpc_id                             = alicloud_vpc.example.id
  transit_router_multicast_domain_id = alicloud_cen_transit_router_multicast_domain_association.example.transit_router_multicast_domain_id
  network_interface_id               = alicloud_ecs_network_interface.example.id
  group_ip_address                   = "239.1.1.1"
}
variable "name" {
  default = "terraform-example"
}

resource "alicloud_cen_instance" "example" {
  cen_instance_name = var.name
}

resource "alicloud_cen_transit_router" "example" {
  transit_router_name = var.name
  cen_id              = alicloud_cen_instance.example.id
  support_multicast   = true
}

resource "alicloud_cen_transit_router_multicast_domain" "default" {
  transit_router_id                           = alicloud_cen_transit_router.example.transit_router_id
  transit_router_multicast_domain_name        = var.name
  transit_router_multicast_domain_description = var.name
  options {
    igmpv2_support = "disable"
  }
}
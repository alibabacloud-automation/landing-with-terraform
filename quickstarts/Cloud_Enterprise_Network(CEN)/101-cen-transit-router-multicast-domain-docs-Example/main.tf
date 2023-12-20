resource "alicloud_cen_instance" "example" {
  cen_instance_name = "tf_example"
  description       = "an example for cen"
}

resource "alicloud_cen_transit_router" "example" {
  transit_router_name = "tf_example"
  cen_id              = alicloud_cen_instance.example.id
  support_multicast   = true
}

resource "alicloud_cen_transit_router_multicast_domain" "example" {
  transit_router_id                           = alicloud_cen_transit_router.example.transit_router_id
  transit_router_multicast_domain_name        = "tf_example"
  transit_router_multicast_domain_description = "tf_example"
}
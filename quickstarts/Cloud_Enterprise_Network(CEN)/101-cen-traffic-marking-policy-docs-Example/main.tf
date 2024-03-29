resource "alicloud_cen_instance" "example" {
  cen_instance_name = "tf_example"
  description       = "an example for cen"
}

resource "alicloud_cen_transit_router" "example" {
  transit_router_name = "tf_example"
  cen_id              = alicloud_cen_instance.example.id
}

resource "alicloud_cen_traffic_marking_policy" "example" {
  marking_dscp                = 1
  priority                    = 1
  traffic_marking_policy_name = "tf_example"
  transit_router_id           = alicloud_cen_transit_router.example.transit_router_id
}
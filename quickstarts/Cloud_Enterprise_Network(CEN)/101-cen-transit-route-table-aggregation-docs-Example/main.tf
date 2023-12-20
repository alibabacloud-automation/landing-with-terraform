resource "alicloud_cen_instance" "example" {
  cen_instance_name = "tf_example"
  description       = "an example for cen"
}

resource "alicloud_cen_transit_router" "example" {
  transit_router_name = "tf_example"
  cen_id              = alicloud_cen_instance.example.id
}

resource "alicloud_cen_transit_router_route_table" "example" {
  transit_router_id = alicloud_cen_transit_router.example.transit_router_id
}

resource "alicloud_cen_transit_route_table_aggregation" "example" {
  transit_route_table_id                      = alicloud_cen_transit_router_route_table.example.transit_router_route_table_id
  transit_route_table_aggregation_cidr        = "10.0.0.0/8"
  transit_route_table_aggregation_scope       = "VPC"
  transit_route_table_aggregation_name        = "tf_example"
  transit_route_table_aggregation_description = "tf_example"
}
data "alicloud_account" "default" {}
resource "alicloud_vpc_prefix_list" "example" {
  entrys {
    cidr = "192.168.0.0/16"
  }
}

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

resource "alicloud_cen_transit_router_prefix_list_association" "example" {
  prefix_list_id          = alicloud_vpc_prefix_list.example.id
  transit_router_id       = alicloud_cen_transit_router.example.transit_router_id
  transit_router_table_id = alicloud_cen_transit_router_route_table.example.transit_router_route_table_id
  next_hop                = "BlackHole"
  next_hop_type           = "BlackHole"
  owner_uid               = data.alicloud_account.default.id
}
resource "alicloud_vpc_traffic_mirror_filter" "example" {
  traffic_mirror_filter_name = "example_value"
}

resource "alicloud_vpc_traffic_mirror_filter_egress_rule" "default" {
  action                   = "drop"
  priority                 = "2"
  source_cidr_block        = "10.0.0.0/11"
  destination_cidr_block   = "10.0.0.0/12"
  traffic_mirror_filter_id = alicloud_vpc_traffic_mirror_filter.example.id
  protocol                 = "ALL"
}

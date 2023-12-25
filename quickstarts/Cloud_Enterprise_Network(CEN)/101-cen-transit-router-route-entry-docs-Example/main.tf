provider "alicloud" {
  region = "cn-hangzhou"
}
variable "name" {
  default = "tf_example"
}
resource "alicloud_cen_instance" "example" {
  cen_instance_name = var.name
  description       = "an example for cen"
}

resource "alicloud_cen_transit_router" "example" {
  transit_router_name = var.name
  cen_id              = alicloud_cen_instance.example.id
}

resource "alicloud_cen_transit_router_route_table" "example" {
  transit_router_id = alicloud_cen_transit_router.example.transit_router_id
}

data "alicloud_express_connect_physical_connections" "example" {
  name_regex = "^preserved-NODELETING"
}
resource "random_integer" "vlan_id" {
  max = 2999
  min = 1
}
resource "alicloud_express_connect_virtual_border_router" "example" {
  local_gateway_ip           = "10.0.0.1"
  peer_gateway_ip            = "10.0.0.2"
  peering_subnet_mask        = "255.255.255.252"
  physical_connection_id     = data.alicloud_express_connect_physical_connections.example.connections.0.id
  virtual_border_router_name = var.name
  vlan_id                    = random_integer.vlan_id.id
  min_rx_interval            = 1000
  min_tx_interval            = 1000
  detect_multiplier          = 10
}
resource "alicloud_cen_transit_router_vbr_attachment" "example" {
  vbr_id                                = alicloud_express_connect_virtual_border_router.example.id
  cen_id                                = alicloud_cen_instance.example.id
  transit_router_id                     = alicloud_cen_transit_router.example.transit_router_id
  auto_publish_route_enabled            = true
  transit_router_attachment_name        = var.name
  transit_router_attachment_description = var.name
}

resource "alicloud_cen_transit_router_route_entry" "example" {
  transit_router_route_table_id                     = alicloud_cen_transit_router_route_table.example.transit_router_route_table_id
  transit_router_route_entry_destination_cidr_block = "192.168.0.0/24"
  transit_router_route_entry_next_hop_type          = "Attachment"
  transit_router_route_entry_name                   = var.name
  transit_router_route_entry_description            = var.name
  transit_router_route_entry_next_hop_id            = alicloud_cen_transit_router_vbr_attachment.example.transit_router_attachment_id
}
provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tf-example"
}
data "alicloud_regions" "default" {
  current = true
}
data "alicloud_express_connect_physical_connections" "example" {
  name_regex = "^preserved-NODELETING"
}
resource "random_integer" "vlan_id" {
  max = 2999
  min = 1
}
resource "alicloud_express_connect_virtual_border_router" "example" {
  count                      = 2
  local_gateway_ip           = "10.0.0.1"
  peer_gateway_ip            = "10.0.0.2"
  peering_subnet_mask        = "255.255.255.252"
  physical_connection_id     = data.alicloud_express_connect_physical_connections.example.connections[count.index].id
  virtual_border_router_name = format("${var.name}-%d", count.index + 1)
  vlan_id                    = random_integer.vlan_id.id + count.index
  min_rx_interval            = 1000
  min_tx_interval            = 1000
  detect_multiplier          = 10
}

resource "alicloud_cen_instance" "example" {
  cen_instance_name = var.name
  description       = var.name
  protection_level  = "REDUCED"
}

resource "alicloud_cen_instance_attachment" "example" {
  count                    = 2
  instance_id              = alicloud_cen_instance.example.id
  child_instance_id        = alicloud_express_connect_virtual_border_router.example[count.index].id
  child_instance_type      = "VBR"
  child_instance_region_id = data.alicloud_regions.default.regions.0.id
}

resource "alicloud_vpc_vbr_ha" "example" {
  vbr_id      = alicloud_cen_instance_attachment.example[0].child_instance_id
  peer_vbr_id = alicloud_cen_instance_attachment.example[1].child_instance_id
  vbr_ha_name = var.name
  description = var.name
}
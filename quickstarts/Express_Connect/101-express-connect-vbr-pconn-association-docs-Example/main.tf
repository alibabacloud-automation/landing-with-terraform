provider "alicloud" {
  region = "cn-hangzhou"
}
variable "name" {
  default = "tf-example"
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
  enable_ipv6                = true
  local_ipv6_gateway_ip      = "2408:4004:cc:400::1"
  peer_ipv6_gateway_ip       = "2408:4004:cc:400::2"
  peering_ipv6_subnet_mask   = "2408:4004:cc:400::/56"
}

resource "alicloud_express_connect_vbr_pconn_association" "example" {
  peer_gateway_ip          = "10.0.0.6"
  local_gateway_ip         = "10.0.0.5"
  physical_connection_id   = data.alicloud_express_connect_physical_connections.example.connections.2.id
  vbr_id                   = alicloud_express_connect_virtual_border_router.example.id
  peering_subnet_mask      = "255.255.255.252"
  vlan_id                  = random_integer.vlan_id.id + 2
  enable_ipv6              = true
  local_ipv6_gateway_ip    = "2408:4004:cc::3"
  peer_ipv6_gateway_ip     = "2408:4004:cc::4"
  peering_ipv6_subnet_mask = "2408:4004:cc::/56"
}
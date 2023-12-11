variable "name" {
  default = "tfacc"
}

data "alicloud_vpn_gateways" "default" {
}

resource "alicloud_vpn_customer_gateway" "default" {
  name       = var.name
  ip_address = "192.168.1.1"
}

resource "alicloud_vpn_connection" "default" {
  name                = var.name
  customer_gateway_id = alicloud_vpn_customer_gateway.default.id
  vpn_gateway_id      = data.alicloud_vpn_gateways.default.ids.0
  local_subnet        = ["192.168.2.0/24"]
  remote_subnet       = ["192.168.3.0/24"]
}

resource "alicloud_vpn_pbr_route_entry" "default" {
  vpn_gateway_id = data.alicloud_vpn_gateways.default.ids.0
  route_source   = "192.168.1.0/24"
  route_dest     = "10.0.0.0/24"
  next_hop       = alicloud_vpn_connection.default.id
  weight         = 0
  publish_vpc    = false
}

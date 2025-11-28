provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "terraform-example"
}

data "alicloud_account" "default" {
}

data "alicloud_express_connect_physical_connections" "default" {
  name_regex = "^preserved-NODELETING"
}

resource "random_integer" "default" {
  max = 2999
  min = 1
}

resource "alicloud_express_connect_virtual_border_router" "default" {
  local_gateway_ip           = "10.0.0.1"
  peer_gateway_ip            = "10.0.0.2"
  peering_subnet_mask        = "255.255.255.252"
  physical_connection_id     = data.alicloud_express_connect_physical_connections.default.connections.0.id
  virtual_border_router_name = var.name
  vlan_id                    = random_integer.default.id
  min_rx_interval            = 1000
  min_tx_interval            = 1000
  detect_multiplier          = 10
}

resource "alicloud_cen_instance" "default" {
  cen_instance_name = var.name
}

resource "alicloud_express_connect_grant_rule_to_cen" "default" {
  cen_id       = alicloud_cen_instance.default.id
  cen_owner_id = data.alicloud_account.default.id
  instance_id  = alicloud_express_connect_virtual_border_router.default.id
}
variable "name" {
  default = "tf-example"
}

data "alicloud_zones" "default" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}
data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = data.alicloud_zones.default.ids.0
}

resource "alicloud_vpn_gateway" "default" {
  name                 = "terraform-example"
  vpc_id               = data.alicloud_vpcs.default.ids.0
  bandwidth            = 10
  instance_charge_type = "PrePaid"
  enable_ssl           = false
  vswitch_id           = data.alicloud_vswitches.default.ids.0
}

resource "alicloud_vpn_connection" "default" {
  name                = var.name
  customer_gateway_id = alicloud_vpn_customer_gateway.default.id
  vpn_gateway_id      = alicloud_vpn_gateway.default.id
  local_subnet        = ["192.168.2.0/24"]
  remote_subnet       = ["192.168.3.0/24"]
}

resource "alicloud_vpn_customer_gateway" "default" {
  name       = var.name
  ip_address = "192.168.1.1"
}

resource "alicloud_vpn_route_entry" "default" {
  vpn_gateway_id = alicloud_vpn_gateway.default.id
  route_dest     = "10.0.0.0/24"
  next_hop       = alicloud_vpn_connection.default.id
  weight         = 0
  publish_vpc    = false
}

variable "name" {
  default = "tf-example"
}
provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_zones" "default" {
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
  name                 = var.name
  vpc_id               = data.alicloud_vpcs.default.ids.0
  bandwidth            = "10"
  enable_ssl           = true
  description          = var.name
  instance_charge_type = "PrePaid"
  vswitch_id           = data.alicloud_vswitches.default.ids.0
}

resource "alicloud_vpn_ipsec_server" "foo" {
  client_ip_pool    = "10.0.0.0/24"
  ipsec_server_name = var.name
  local_subnet      = "192.168.0.0/24"
  vpn_gateway_id    = alicloud_vpn_gateway.default.id
  psk_enabled       = true
}

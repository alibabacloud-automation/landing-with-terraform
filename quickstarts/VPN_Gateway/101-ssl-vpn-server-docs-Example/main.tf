variable "name" {
  default = "terraform-example"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
  cidr_block = "172.16.0.0/16"
}

data "alicloud_vswitches" "default0" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = data.alicloud_zones.default.ids.0
}

data "alicloud_vswitches" "default1" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = data.alicloud_zones.default.ids.1
}

resource "alicloud_vpn_gateway" "default" {
  vpn_gateway_name             = var.name
  vpc_id                       = data.alicloud_vpcs.default.ids.0
  bandwidth                    = "10"
  enable_ssl                   = true
  description                  = var.name
  payment_type                 = "Subscription"
  vswitch_id                   = data.alicloud_vswitches.default0.ids.0
  disaster_recovery_vswitch_id = data.alicloud_vswitches.default1.ids.0
}

resource "alicloud_ssl_vpn_server" "default" {
  name           = var.name
  vpn_gateway_id = alicloud_vpn_gateway.default.id
  client_ip_pool = "192.168.0.0/16"
  local_subnet   = cidrsubnet(data.alicloud_vpcs.default.vpcs.0.cidr_block, 8, 8)
  protocol       = "UDP"
  cipher         = "AES-128-CBC"
  port           = "1194"
  compress       = "false"
}
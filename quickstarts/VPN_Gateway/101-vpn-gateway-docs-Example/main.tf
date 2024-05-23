variable "name" {
  default = "terraform-example"
}

variable "spec" {
  default = "20"
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
  vpn_type         = "Normal"
  vpn_gateway_name = var.name

  vswitch_id                   = data.alicloud_vswitches.default0.ids.0
  disaster_recovery_vswitch_id = data.alicloud_vswitches.default1.ids.0
  auto_pay                     = true
  vpc_id                       = data.alicloud_vpcs.default.ids.0
  network_type                 = "public"
  payment_type                 = "Subscription"
  enable_ipsec                 = true
  bandwidth                    = var.spec
}
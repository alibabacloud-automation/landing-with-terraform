variable "name" {
  default = "terraform-example"
}
provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

data "alicloud_vpcs" "default" {
  name_regex = var.name
}

data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = "cn-hangzhou-k"
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
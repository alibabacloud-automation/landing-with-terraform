provider "alicloud" {
  region = "cn-beijing"
}
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

variable "instance_series" {
  default = "drds.sn1.4c8g"
}

data "alicloud_vpcs" "default" {
  name_regex = "default-NODELETING"
}
data "alicloud_vswitches" "default" {
  vpc_id = data.alicloud_vpcs.default.ids.0
}

resource "alicloud_drds_instance" "default" {
  description          = "drds instance"
  instance_charge_type = "PostPaid"
  zone_id              = data.alicloud_vswitches.default.vswitches.0.zone_id
  vswitch_id           = data.alicloud_vswitches.default.vswitches.0.id
  instance_series      = var.instance_series
  specification        = "drds.sn1.4c8g.8C16G"
}
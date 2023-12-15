variable "name" {
  default = "terraform-example"
}

data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}

resource "alicloud_common_bandwidth_package" "default" {
  bandwidth_package_name    = var.name
  description               = var.name
  isp                       = "BGP"
  bandwidth                 = "1000"
  ratio                     = 100
  internet_charge_type      = "PayByBandwidth"
  resource_group_id         = data.alicloud_resource_manager_resource_groups.default.ids.0
  security_protection_types = ["AntiDDoS_Enhanced"]
}
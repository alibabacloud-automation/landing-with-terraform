variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_zones" "default" {}

data "alicloud_resource_manager_resource_groups" "default" {}

resource "alicloud_ocean_base_instance" "default" {
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.ids.0
  zones = [
    "${data.alicloud_zones.default.ids[length(data.alicloud_zones.default.ids) - 2]}",
    "${data.alicloud_zones.default.ids[length(data.alicloud_zones.default.ids) - 3]}",
    "${data.alicloud_zones.default.ids[length(data.alicloud_zones.default.ids) - 4]}"
  ]
  auto_renew         = "false"
  disk_size          = "100"
  payment_type       = "PayAsYouGo"
  instance_class     = "8C32GB"
  backup_retain_mode = "delete_all"
  series             = "normal"
  instance_name      = var.name
}
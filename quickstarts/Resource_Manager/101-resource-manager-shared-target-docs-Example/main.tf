variable "name" {
  default = "terraform-example"
}

data "alicloud_resource_manager_accounts" "default" {
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_resource_manager_resource_share" "default" {
  resource_share_name = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_resource_manager_shared_target" "default" {
  resource_share_id = alicloud_resource_manager_resource_share.default.id
  target_id         = data.alicloud_resource_manager_accounts.default.ids.0
}
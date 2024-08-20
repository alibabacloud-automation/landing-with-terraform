variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

data "alicloud_account" "default" {
}

data "alicloud_governance_baselines" "default" {
}

data "alicloud_resource_manager_folders" "default" {
}

resource "alicloud_governance_account" "default" {
  account_name_prefix = "${var.name}-${random_integer.default.result}"
  folder_id           = data.alicloud_resource_manager_folders.default.ids.0
  baseline_id         = data.alicloud_governance_baselines.default.ids.0
  payer_account_id    = data.alicloud_account.default.id
  display_name        = "${var.name}-${random_integer.default.result}"
}
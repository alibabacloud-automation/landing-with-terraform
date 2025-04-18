variable "name" {
  default = "tf-example"
}
provider "alicloud" {
  region = "cn-shanghai"
}
data "alicloud_cloud_sso_directories" "default" {}
data "alicloud_resource_manager_resource_directories" "default" {}

resource "alicloud_cloud_sso_directory" "default" {
  count          = length(data.alicloud_cloud_sso_directories.default.ids) > 0 ? 0 : 1
  directory_name = var.name
}

locals {
  directory_id = length(data.alicloud_cloud_sso_directories.default.ids) > 0 ? data.alicloud_cloud_sso_directories.default.ids[0] : concat(alicloud_cloud_sso_directory.default.*.id, [""])[0]
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_cloud_sso_user" "default" {
  directory_id = local.directory_id
  user_name    = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_cloud_sso_access_configuration" "default" {
  access_configuration_name = "${var.name}-${random_integer.default.result}"
  directory_id              = local.directory_id
}

resource "alicloud_cloud_sso_access_configuration_provisioning" "default" {
  directory_id            = local.directory_id
  access_configuration_id = alicloud_cloud_sso_access_configuration.default.access_configuration_id
  target_type             = "RD-Account"
  target_id               = data.alicloud_resource_manager_resource_directories.default.directories.0.master_account_id
}
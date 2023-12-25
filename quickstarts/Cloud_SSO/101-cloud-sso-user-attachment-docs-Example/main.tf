variable "name" {
  default = "tf-example"
}
provider "alicloud" {
  region = "cn-shanghai"
}
data "alicloud_cloud_sso_directories" "default" {}

resource "alicloud_cloud_sso_directory" "default" {
  count          = length(data.alicloud_cloud_sso_directories.default.ids) > 0 ? 0 : 1
  directory_name = var.name
}

locals {
  directory_id = length(data.alicloud_cloud_sso_directories.default.ids) > 0 ? data.alicloud_cloud_sso_directories.default.ids[0] : concat(alicloud_cloud_sso_directory.default.*.id, [""])[0]
}
resource "alicloud_cloud_sso_user" "default" {
  directory_id = local.directory_id
  user_name    = var.name
}

resource "alicloud_cloud_sso_group" "default" {
  directory_id = local.directory_id
  group_name   = var.name
  description  = var.name
}

resource "alicloud_cloud_sso_user_attachment" "default" {
  directory_id = local.directory_id
  user_id      = alicloud_cloud_sso_user.default.user_id
  group_id     = alicloud_cloud_sso_group.default.group_id
}
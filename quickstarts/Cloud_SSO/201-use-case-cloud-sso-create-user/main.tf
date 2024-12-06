variable "region" {
  default = "cn-shanghai"
}

provider "alicloud" {
  region = var.region
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

# 获取云SSO目录
data "alicloud_cloud_sso_directories" "default" {}

# 创建目录
resource "alicloud_cloud_sso_directory" "default" {
  directory_name = "sso-directory-${random_integer.default.result}"
  # 如果已有目录，则不新建目录；如果没有目录，则新建一个目录
  count = length(data.alicloud_cloud_sso_directories.default.ids) > 0 ? 0 : 1
}

# directory_id 的值为全局唯一目录的id
locals {
  directory_id = length(data.alicloud_cloud_sso_directories.default.ids) > 0 ? data.alicloud_cloud_sso_directories.default.ids[0] : concat(alicloud_cloud_sso_directory.default.*.id, [""])[0]
}

# 创建云SSO用户
resource "alicloud_cloud_sso_user" "default" {
  user_name    = "sso-user-${random_integer.default.result}"
  directory_id = local.directory_id
}
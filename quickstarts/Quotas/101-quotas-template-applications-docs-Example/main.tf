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

resource "alicloud_resource_manager_account" "account" {
  display_name = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_quotas_template_applications" "default" {
  env_language      = "zh"
  notice_type       = "0"
  quota_category    = "WhiteListLabel"
  desire_value      = "1"
  reason            = "example"
  quota_action_code = "quotas.label_multi/A"
  aliyun_uids = [
    "${alicloud_resource_manager_account.account.id}"
  ]
  product_code = "quotas"
}
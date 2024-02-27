variable "name" {
  default = "terraform-example"
}


resource "alicloud_quotas_template_quota" "default" {
  quota_action_code = "q_desktop-count"
  product_code      = "gws"
  notice_type       = 3
  dimensions {
    key   = "regionId"
    value = "cn-hangzhou"
  }
  desire_value   = 1001
  env_language   = "zh"
  quota_category = "CommonQuota"
}
variable "name" {
  default = "terraform-example"
}

resource "alicloud_esa_rate_plan_instance" "example" {
  type         = "NS"
  auto_renew   = "false"
  period       = "1"
  payment_type = "Subscription"
  coverage     = "overseas"
  auto_pay     = "true"
  plan_name    = "high"
}

resource "alicloud_esa_site" "resource_HttpBasicConfiguration_set_example" {
  site_name   = "gositecdn.cn"
  instance_id = alicloud_esa_rate_plan_instance.example.id
  coverage    = "overseas"
  access_type = "NS"
}

resource "alicloud_esa_https_basic_configuration" "default" {
  https       = "on"
  rule        = "true"
  rule_name   = "example2"
  site_id     = alicloud_esa_site.resource_HttpBasicConfiguration_set_example.id
  rule_enable = "on"
}
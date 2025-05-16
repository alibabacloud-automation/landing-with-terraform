variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_esa_rate_plan_instance" "resource_RedirectRule_example" {
  type         = "NS"
  auto_renew   = "false"
  period       = "1"
  payment_type = "Subscription"
  coverage     = "overseas"
  auto_pay     = "true"
  plan_name    = "high"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_esa_site" "resource_Site_RedirectRule_example" {
  site_name   = "gositecdn-${random_integer.default.result}.cn"
  instance_id = alicloud_esa_rate_plan_instance.resource_RedirectRule_example.id
  coverage    = "overseas"
  access_type = "NS"
}

resource "alicloud_esa_redirect_rule" "default" {
  status_code          = "301"
  rule_name            = "example"
  site_id              = alicloud_esa_site.resource_Site_RedirectRule_example.id
  type                 = "static"
  reserve_query_string = "on"
  target_url           = "http://www.exapmle.com/index.html"
  rule_enable          = "on"
  site_version         = "0"
  rule                 = "(http.host eq \"video.example.com\")"
}
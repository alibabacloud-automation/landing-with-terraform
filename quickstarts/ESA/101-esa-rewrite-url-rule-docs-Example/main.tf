variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_esa_rate_plan_instance" "resource_RewriteUrlRule_RatePlanInstance_example" {
  type         = "NS"
  auto_renew   = "false"
  period       = "1"
  payment_type = "Subscription"
  coverage     = "overseas"
  auto_pay     = "true"
  plan_name    = "high"
}

resource "alicloud_esa_site" "resource_RewriteUrlRule_Site_example" {
  site_name   = "gositecdn.cn"
  instance_id = alicloud_esa_rate_plan_instance.resource_RewriteUrlRule_RatePlanInstance_example.id
  coverage    = "overseas"
  access_type = "NS"
}

resource "alicloud_esa_rewrite_url_rule" "default" {
  rewrite_uri_type          = "static"
  rewrite_query_string_type = "static"
  site_id                   = alicloud_esa_site.resource_RewriteUrlRule_Site_example.id
  rule_name                 = "example"
  rule_enable               = "on"
  query_string              = "example=123"
  site_version              = "0"
  rule                      = "http.host eq \"video.example.com\""
  uri                       = "/image/example.jpg"
}
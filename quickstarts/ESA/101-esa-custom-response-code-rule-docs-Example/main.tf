variable "name" {
  default = "terraform-example"
}

resource "alicloud_esa_rate_plan_instance" "resource_RatePlanInstance_CustomResponseCodeRule_example" {
  type         = "NS"
  auto_renew   = false
  period       = "1"
  payment_type = "Subscription"
  coverage     = "overseas"
  auto_pay     = true
  plan_name    = "basic"
}

resource "alicloud_esa_site" "resource_Site_CustomResponseCodeRule_example" {
  site_name   = "hyhexample.cn"
  instance_id = alicloud_esa_rate_plan_instance.resource_RatePlanInstance_CustomResponseCodeRule_example.id
  coverage    = "overseas"
  access_type = "NS"
}


resource "alicloud_esa_custom_response_code_rule" "default" {
  page_id      = "0"
  site_id      = alicloud_esa_site.resource_Site_CustomResponseCodeRule_example.id
  return_code  = "400"
  rule_enable  = "on"
  rule         = "(http.host eq \"video.example.com\")"
  sequence     = "1"
  site_version = "0"
  rule_name    = var.name
}
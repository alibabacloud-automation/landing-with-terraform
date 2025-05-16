provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "terraform-example"
}

resource "alicloud_esa_rate_plan_instance" "resource_HttpResponseHeaderModificationRule_example" {
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

resource "alicloud_esa_site" "resource_Site_HttpResponseHeaderModificationRule_example" {
  site_name   = "gositecdn-${random_integer.default.result}.cn"
  instance_id = alicloud_esa_rate_plan_instance.resource_HttpResponseHeaderModificationRule_example.id
  coverage    = "overseas"
  access_type = "NS"
}

resource "alicloud_esa_http_response_header_modification_rule" "default" {
  rule_enable = "on"
  response_header_modification {
    value     = "add"
    operation = "add"
    name      = "exampleadd"
  }
  response_header_modification {
    operation = "del"
    name      = "exampledel"
  }
  response_header_modification {
    operation = "modify"
    name      = "examplemodify"
    value     = "modify"
  }

  rule         = "(http.host eq \"video.example.com\")"
  site_version = "0"
  rule_name    = "exampleResponseHeader"
  site_id      = alicloud_esa_site.resource_Site_HttpResponseHeaderModificationRule_example.id
}
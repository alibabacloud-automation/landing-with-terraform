variable "name" {
  default = "terraform-example"
}
resource "random_integer" "default" {
  min = 10000
  max = 99999
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_esa_rate_plan_instance" "resource_HttpIncomingResponseHeaderModificationRule_example" {
  type         = "NS"
  auto_renew   = false
  period       = "1"
  payment_type = "Subscription"
  coverage     = "overseas"
  auto_pay     = true
  plan_name    = "basic"
}

resource "alicloud_esa_site" "resource_Site_HttpIncomingResponseHeaderModificationRule_example" {
  site_name   = "gositecdn${random_integer.default.result}.cn"
  instance_id = alicloud_esa_rate_plan_instance.resource_HttpIncomingResponseHeaderModificationRule_example.id
  coverage    = "overseas"
  access_type = "NS"
}


resource "alicloud_esa_http_incoming_response_header_modification_rule" "default" {
  site_id     = alicloud_esa_site.resource_Site_HttpIncomingResponseHeaderModificationRule_example.id
  rule_enable = "on"
  response_header_modification {
    type      = "static"
    value     = "add"
    operation = "add"
    name      = "exampleadd"
  }
  response_header_modification {
    type      = "static"
    operation = "del"
    name      = "exampledel"
  }
  response_header_modification {
    type      = "static"
    value     = "modify"
    operation = "modify"
    name      = "examplemodify"
  }
  rule         = "(http.host eq \"video.example.com\")"
  sequence     = "1"
  site_version = "0"
  rule_name    = "exampleResponseHeader"
}
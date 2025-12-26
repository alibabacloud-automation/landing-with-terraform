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

resource "alicloud_esa_rate_plan_instance" "resource_HttpIncomingRequestHeaderModificationRule_example" {
  type         = "NS"
  auto_renew   = false
  period       = "1"
  payment_type = "Subscription"
  coverage     = "overseas"
  auto_pay     = true
  plan_name    = "high"
}

resource "alicloud_esa_site" "resource_Site_HttpIncomingRequestHeaderModificationRule_example" {
  site_name   = "gositecdn${random_integer.default.result}.cn"
  instance_id = alicloud_esa_rate_plan_instance.resource_HttpIncomingRequestHeaderModificationRule_example.id
  coverage    = "overseas"
  access_type = "NS"
}


resource "alicloud_esa_http_incoming_request_header_modification_rule" "default" {
  site_id      = alicloud_esa_site.resource_Site_HttpIncomingRequestHeaderModificationRule_example.id
  rule_enable  = "on"
  rule         = "(http.host eq \"video.example.com\")"
  sequence     = "1"
  site_version = "0"
  rule_name    = "example"
  request_header_modification {
    type      = "static"
    value     = "add"
    operation = "add"
    name      = "exampleadd"
  }
  request_header_modification {
    operation = "del"
    name      = "exampledel"
  }
  request_header_modification {
    type      = "dynamic"
    value     = "ip.geoip.country"
    operation = "modify"
    name      = "examplemodify"
  }
}
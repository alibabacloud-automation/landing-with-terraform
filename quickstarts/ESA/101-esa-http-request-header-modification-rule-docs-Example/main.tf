provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "terraform-example"
}

resource "alicloud_esa_rate_plan_instance" "instance" {
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

resource "alicloud_esa_site" "site" {
  site_name   = "gositecdn-${random_integer.default.result}.cn"
  instance_id = alicloud_esa_rate_plan_instance.instance.id
  coverage    = "overseas"
  access_type = "NS"
}


resource "alicloud_esa_http_request_header_modification_rule" "default" {
  rule_name = "example_modify"
  request_header_modification {
    value     = "modify1"
    operation = "modify"
    name      = "example_modify1"
  }

  site_id      = alicloud_esa_site.site.id
  rule_enable  = "off"
  rule         = "(http.request.uri eq \"/content?page=1234\")"
  site_version = "0"
}
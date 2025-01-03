variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_esa_rate_plan_instance" "default" {
  type         = "NS"
  auto_renew   = "false"
  period       = "1"
  payment_type = "Subscription"
  coverage     = "overseas"
  auto_pay     = "true"
  plan_name    = "high"
}

resource "alicloud_esa_site" "default" {
  site_name   = "idlexamplerecord.com"
  instance_id = alicloud_esa_rate_plan_instance.default.id
  coverage    = "overseas"
  access_type = "NS"
}

resource "alicloud_esa_record" "default" {
  data {
    value    = "www.eerrraaa.com"
    weight   = "1"
    priority = "1"
    port     = "80"
  }

  ttl         = "100"
  record_name = "_udp._sip.idlexamplerecord.com"
  comment     = "This is a remark"
  site_id     = alicloud_esa_site.default.id
  record_type = "SRV"
}
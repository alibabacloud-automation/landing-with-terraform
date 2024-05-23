provider "alicloud" {
  region = var.region
}

variable "region" {
  default = "cn-hangzhou"
}

resource "alicloud_ga_basic_accelerator" "default" {
  duration               = 1
  pricing_cycle          = "Month"
  bandwidth_billing_type = "CDT"
  auto_pay               = true
  auto_use_coupon        = "true"
  auto_renew             = false
  auto_renew_duration    = 1
}

resource "alicloud_ga_basic_ip_set" "default" {
  accelerator_id       = alicloud_ga_basic_accelerator.default.id
  accelerate_region_id = var.region
  isp_type             = "BGP"
  bandwidth            = "5"
}
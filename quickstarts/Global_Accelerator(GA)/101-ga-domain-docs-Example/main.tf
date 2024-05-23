resource "alicloud_ga_accelerator" "default" {
  duration        = 1
  auto_use_coupon = true
  spec            = "1"
}

resource "alicloud_ga_domain" "default" {
  domain         = "changes.com.cn"
  accelerator_id = alicloud_ga_accelerator.default.id
}
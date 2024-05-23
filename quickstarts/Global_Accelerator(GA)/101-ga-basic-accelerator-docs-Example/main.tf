resource "alicloud_ga_basic_accelerator" "default" {
  duration               = 1
  pricing_cycle          = "Month"
  basic_accelerator_name = "tf-example-value"
  description            = "tf-example-value"
  bandwidth_billing_type = "BandwidthPackage"
  auto_pay               = true
  auto_use_coupon        = "true"
}
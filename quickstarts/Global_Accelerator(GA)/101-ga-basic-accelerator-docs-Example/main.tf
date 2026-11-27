terraform {
  required_providers {
    alicloud = {
      source = "aliyun/alicloud"
    }
  }
}

resource "alicloud_ga_basic_accelerator" "default" {
  payment_type           = "PayAsYouGo"
  basic_accelerator_name = "tf-example-value"
  description            = "tf-example-value"
  bandwidth_billing_type = "CDT"
}
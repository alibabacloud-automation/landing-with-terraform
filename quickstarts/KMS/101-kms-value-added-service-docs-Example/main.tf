variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_kms_value_added_service" "default" {
  value_added_service = "2"
  period              = "1"
  payment_type        = "Subscription"
  renew_period        = "1"
  renew_status        = "AutoRenewal"
}
variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_esa_cache_reserve_instance" "default" {
  quota_gb     = "10240"
  cr_region    = "CN-beijing"
  auto_renew   = true
  period       = "1"
  payment_type = "Subscription"
  auto_pay     = true
}
variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_esa_rate_plan_instance" "default" {
  type         = "NS"
  auto_renew   = true
  period       = "1"
  payment_type = "Subscription"
  coverage     = "overseas"
  plan_name    = "basic"
  auto_pay     = true
}
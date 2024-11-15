variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_resource_manager_resource_groups" "default" {
}

resource "alicloud_esa_rate_plan_instance" "defaultIEoDfU" {
  type         = "NS"
  auto_renew   = true
  period       = "1"
  payment_type = "Subscription"
  coverage     = "overseas"
  auto_pay     = true
  plan_name    = "basic"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_esa_site" "default" {
  site_name         = "bcd${random_integer.default.result}.com"
  coverage          = "overseas"
  access_type       = "NS"
  instance_id       = alicloud_esa_rate_plan_instance.defaultIEoDfU.id
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.ids.0
}
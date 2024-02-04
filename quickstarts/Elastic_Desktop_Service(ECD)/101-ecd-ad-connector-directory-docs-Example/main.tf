provider "alicloud" {
  region = "cn-hangzhou"
}
variable "name" {
  default = "terraform-example"
}
data "alicloud_ecd_zones" "default" {}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_ecd_zones.default.ids.0
  vswitch_name = var.name
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_ecd_ad_connector_directory" "default" {
  directory_name         = "${var.name}-${random_integer.default.result}"
  desktop_access_type    = "INTERNET"
  dns_address            = ["127.0.0.2"]
  domain_name            = "corp.example.com"
  domain_password        = "Example1234"
  domain_user_name       = "sAMAccountName"
  enable_admin_access    = false
  mfa_enabled            = false
  specification          = 1
  sub_domain_dns_address = ["127.0.0.3"]
  sub_domain_name        = "child.example.com"
  vswitch_ids            = [alicloud_vswitch.default.id]
}
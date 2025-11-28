provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "terraform-example"
}

data "alicloud_account" "default" {
}

resource "alicloud_eflo_er" "default" {
  er_name        = var.name
  master_zone_id = "cn-hangzhou-a"
}

resource "alicloud_eflo_vpd" "default" {
  cidr     = "10.0.0.0/8"
  vpd_name = var.name
}

resource "alicloud_eflo_vpd_grant_rule" "default" {
  grant_tenant_id = data.alicloud_account.default.id
  er_id           = alicloud_eflo_er.default.id
  instance_id     = alicloud_eflo_vpd.default.id
}
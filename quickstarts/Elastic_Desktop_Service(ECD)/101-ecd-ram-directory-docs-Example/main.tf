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

resource "alicloud_ecd_ram_directory" "default" {
  desktop_access_type = "INTERNET"
  enable_admin_access = true
  ram_directory_name  = var.name
  vswitch_ids         = [alicloud_vswitch.default.id]
}
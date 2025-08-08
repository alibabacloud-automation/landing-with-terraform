variable "vpc_cidr" {}
variable "vsw1_cidr" {}
variable "vsw2_cidr" {}
variable "zone1_id" {}
variable "zone2_id" {}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc_test"
  cidr_block = var.vpc_cidr
}

resource "alicloud_vswitch" "vsw1" {
  vpc_id     = alicloud_vpc.vpc.id
  cidr_block = var.vsw1_cidr
  zone_id    = var.zone1_id
}

resource "alicloud_vswitch" "vsw2" {
  vpc_id     = alicloud_vpc.vpc.id
  cidr_block = var.vsw2_cidr
  zone_id    = var.zone2_id
}

output "vpc_id" {
  value = alicloud_vpc.vpc.id
}
output "vsw1_id" {
  value = alicloud_vswitch.vsw1.id
}
output "vsw2_id" {
  value = alicloud_vswitch.vsw2.id
}
output "route_table_id" {
  value = alicloud_vpc.vpc.route_table_id
}
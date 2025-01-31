provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tf-example"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "10.4.0.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = "cn-hangzhou-e"
}

resource "alicloud_dfs_file_system" "default" {
  storage_type                     = "STANDARD"
  zone_id                          = "cn-hangzhou-e"
  protocol_type                    = "PANGU"
  description                      = var.name
  file_system_name                 = var.name
  throughput_mode                  = "Provisioned"
  space_capacity                   = "1024"
  provisioned_throughput_in_mi_bps = "512"
}

resource "alicloud_dfs_access_group" "default" {
  access_group_name = var.name
  description       = var.name
  network_type      = "VPC"
}

resource "alicloud_dfs_mount_point" "default" {
  description     = var.name
  vpc_id          = alicloud_vpc.default.id
  file_system_id  = alicloud_dfs_file_system.default.id
  access_group_id = alicloud_dfs_access_group.default.id
  network_type    = "VPC"
  vswitch_id      = alicloud_vswitch.default.id
}
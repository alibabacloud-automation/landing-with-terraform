provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tf-example"
}

data "alicloud_dfs_zones" "default" {}

resource "alicloud_dfs_file_system" "default" {
  storage_type                     = data.alicloud_dfs_zones.default.zones.0.options.0.storage_type
  zone_id                          = data.alicloud_dfs_zones.default.zones.0.zone_id
  protocol_type                    = "HDFS"
  description                      = var.name
  file_system_name                 = var.name
  throughput_mode                  = "Provisioned"
  space_capacity                   = "1024"
  provisioned_throughput_in_mi_bps = "512"
}
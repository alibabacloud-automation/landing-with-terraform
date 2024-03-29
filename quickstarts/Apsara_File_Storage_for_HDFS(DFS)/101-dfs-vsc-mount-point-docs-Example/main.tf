variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

data "alicloud_dfs_zones" "default" {}

locals {
  zone_id      = data.alicloud_dfs_zones.default.zones.0.zone_id
  storage_type = data.alicloud_dfs_zones.default.zones.0.options.0.storage_type
}

resource "alicloud_dfs_file_system" "default" {
  protocol_type                    = "HDFS"
  description                      = var.name
  file_system_name                 = "${var.name}-${random_integer.default.result}"
  space_capacity                   = "1024"
  throughput_mode                  = "Provisioned"
  provisioned_throughput_in_mi_bps = "512"
  storage_type                     = local.storage_type
  zone_id                          = local.zone_id
}
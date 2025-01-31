provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tf-example"
}

resource "alicloud_dfs_file_system" "default" {
  storage_type                     = "PERFORMANCE"
  zone_id                          = "cn-hangzhou-b"
  protocol_type                    = "PANGU"
  description                      = var.name
  file_system_name                 = var.name
  throughput_mode                  = "Provisioned"
  space_capacity                   = "1024"
  provisioned_throughput_in_mi_bps = "512"
}
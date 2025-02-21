provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "terraform-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_dfs_file_system" "default" {
  space_capacity       = "1024"
  description          = "for vsc mountpoint RMC test"
  storage_type         = "PERFORMANCE"
  zone_id              = "cn-hangzhou-b"
  protocol_type        = "PANGU"
  data_redundancy_type = "LRS"
  file_system_name     = var.name
}

resource "alicloud_dfs_vsc_mount_point" "DefaultFsForRMCVscMp" {
  file_system_id = alicloud_dfs_file_system.default.id
  alias_prefix   = var.name
  description    = var.name
}
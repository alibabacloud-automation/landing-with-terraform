variable "region" {
  default = "cn-hangzhou"
}

provider "alicloud" {
  region = var.region
}

data "alicloud_nas_zones" "default" {
  file_system_type = "standard"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_nas_file_system" "default" {
  protocol_type    = "NFS"
  storage_type     = "Capacity"
  description      = "nas_system_${random_integer.default.result}"
  encrypt_type     = 1
  file_system_type = "standard"
  recycle_bin {
    status        = "Enable"
    reserved_days = "10"
  }
  nfs_acl {
    enabled = true
  }
  zone_id = data.alicloud_nas_zones.default.zones.0.zone_id
}
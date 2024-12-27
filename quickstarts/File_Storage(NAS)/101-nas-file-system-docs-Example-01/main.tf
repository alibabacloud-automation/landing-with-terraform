variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_nas_zones" "default" {
  file_system_type = "standard"
}

resource "alicloud_nas_file_system" "default" {
  protocol_type    = "NFS"
  storage_type     = "Capacity"
  description      = var.name
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
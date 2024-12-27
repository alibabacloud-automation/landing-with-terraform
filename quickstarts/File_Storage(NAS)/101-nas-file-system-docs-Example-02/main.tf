variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_nas_zones" "default" {
  file_system_type = "extreme"
}

resource "alicloud_nas_file_system" "default" {
  protocol_type    = "NFS"
  storage_type     = "standard"
  capacity         = 100
  description      = var.name
  encrypt_type     = 1
  file_system_type = "extreme"
  zone_id          = data.alicloud_nas_zones.default.zones.0.zone_id
}
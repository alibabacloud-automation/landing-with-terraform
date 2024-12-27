variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_nas_zones" "default" {
  file_system_type = "cpfs"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "172.17.3.0/24"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "172.17.3.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_nas_zones.default.zones.1.zone_id
}

resource "alicloud_nas_file_system" "default" {
  protocol_type    = "cpfs"
  storage_type     = "advance_100"
  capacity         = 5000
  description      = var.name
  file_system_type = "cpfs"
  vswitch_id       = alicloud_vswitch.default.id
  vpc_id           = alicloud_vpc.default.id
  zone_id          = data.alicloud_nas_zones.default.zones.1.zone_id
}
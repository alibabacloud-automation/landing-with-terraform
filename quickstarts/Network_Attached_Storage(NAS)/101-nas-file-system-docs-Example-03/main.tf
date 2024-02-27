provider "alicloud" {
  region = "cn-zhangjiakou"
}

data "alicloud_nas_zones" "example" {
  file_system_type = "cpfs"
}

resource "alicloud_vpc" "example" {
  vpc_name   = "terraform-example"
  cidr_block = "172.17.3.0/24"
}

resource "alicloud_vswitch" "example" {
  vswitch_name = "terraform-example"
  cidr_block   = "172.17.3.0/24"
  vpc_id       = alicloud_vpc.example.id
  zone_id      = data.alicloud_nas_zones.example.zones[1].zone_id
}

resource "alicloud_nas_file_system" "example" {
  protocol_type    = "cpfs"
  storage_type     = "advance_200"
  file_system_type = "cpfs"
  capacity         = 3600
  zone_id          = data.alicloud_nas_zones.example.zones[1].zone_id
  vpc_id           = alicloud_vpc.example.id
  vswitch_id       = alicloud_vswitch.example.id
}
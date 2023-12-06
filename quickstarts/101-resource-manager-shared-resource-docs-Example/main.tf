variable "name" {
  default = "tfexample"
}
data "alicloud_zones" "example" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "example" {
  vpc_name   = var.name
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "example" {
  zone_id      = data.alicloud_zones.example.zones.0.id
  cidr_block   = "192.168.0.0/16"
  vpc_id       = alicloud_vpc.example.id
  vswitch_name = var.name
}

resource "alicloud_resource_manager_resource_share" "example" {
  resource_share_name = var.name
}

resource "alicloud_resource_manager_shared_resource" "example" {
  resource_id       = alicloud_vswitch.example.id
  resource_share_id = alicloud_resource_manager_resource_share.example.id
  resource_type     = "VSwitch"
}

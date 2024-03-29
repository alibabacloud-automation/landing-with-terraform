provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_zones" "example" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "example" {
  vpc_name   = "terraform-example"
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "example" {
  count        = 2
  vpc_id       = alicloud_vpc.example.id
  cidr_block   = format("172.16.%d.0/21", (count.index + 1) * 16)
  zone_id      = data.alicloud_zones.example.zones[count.index].id
  vswitch_name = format("terraform_example_%d", count.index + 1)
}

resource "alicloud_mse_gateway" "example" {
  gateway_name      = "terraform-example"
  replica           = 2
  spec              = "MSE_GTW_2_4_200_c"
  vswitch_id        = alicloud_vswitch.example.0.id
  backup_vswitch_id = alicloud_vswitch.example.1.id
  vpc_id            = alicloud_vpc.example.id
}
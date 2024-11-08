variable "name" {
  default = "terraform-example"
}

data "alicloud_zones" "default" {
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_cloud_storage_gateway_storage_bundle" "default" {
  storage_bundle_name = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_vpc" "default" {
  vpc_name   = "${var.name}-${random_integer.default.result}"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = "${var.name}-${random_integer.default.result}"
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "192.168.192.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_cloud_storage_gateway_gateway" "default" {
  storage_bundle_id        = alicloud_cloud_storage_gateway_storage_bundle.default.id
  type                     = "File"
  location                 = "Cloud"
  gateway_name             = var.name
  gateway_class            = "Standard"
  vswitch_id               = alicloud_vswitch.default.id
  public_network_bandwidth = 50
  payment_type             = "PayAsYouGo"
  description              = var.name
}
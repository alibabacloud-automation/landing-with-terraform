provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tf-example"
}

data "alicloud_kvstore_zones" "default" {
  product_type         = "Tair_essd"
  instance_charge_type = "PostPaid"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "192.168.0.0/24"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "192.168.0.0/24"
  zone_id      = data.alicloud_kvstore_zones.default.zones.1.id
  vpc_id       = alicloud_vpc.default.id
}

data "alicloud_resource_manager_resource_groups" "default" {
}

resource "alicloud_redis_tair_instance" "default" {
  instance_class            = "tair.essd.standard.xlarge"
  secondary_zone_id         = alicloud_vswitch.default.zone_id
  resource_group_id         = data.alicloud_resource_manager_resource_groups.default.groups.0.id
  storage_performance_level = "PL1"
  payment_type              = "PayAsYouGo"
  auto_renew                = "false"
  storage_size_gb           = "20"
  vpc_id                    = alicloud_vswitch.default.vpc_id
  force_upgrade             = "false"
  instance_type             = "tair_essd"
  zone_id                   = alicloud_vswitch.default.zone_id
  period                    = "9"
  port                      = "6379"
  tair_instance_name        = var.name
  vswitch_id                = alicloud_vswitch.default.id
  auto_renew_period         = "1"
}
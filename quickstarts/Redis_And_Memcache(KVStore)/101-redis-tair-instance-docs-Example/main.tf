provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tf-example"
}

data "alicloud_kvstore_zones" "default" {
  product_type = "Tair_rdb"
}

data "alicloud_vpcs" "default" {
  name_regex = "default-NODELETING"
}

data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = data.alicloud_kvstore_zones.default.zones.0.id
}

locals {
  vswitch_id = data.alicloud_vswitches.default.ids.0
  zone_id    = data.alicloud_kvstore_zones.default.zones.0.id
}

data "alicloud_resource_manager_resource_groups" "default" {
}

resource "alicloud_redis_tair_instance" "default" {
  payment_type       = "Subscription"
  period             = "1"
  instance_type      = "tair_rdb"
  zone_id            = local.zone_id
  instance_class     = "tair.rdb.2g"
  shard_count        = "2"
  vswitch_id         = local.vswitch_id
  vpc_id             = data.alicloud_vpcs.default.ids.0
  tair_instance_name = var.name
}
provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "terraform-example"
}

variable "zone_id" {
  default = "cn-hangzhou-h"
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}

data "alicloud_vswitches" "default" {
  zone_id = var.zone_id
  vpc_id  = data.alicloud_vpcs.default.ids.0
}

resource "alicloud_vswitch" "vswitch" {
  count        = length(data.alicloud_vswitches.default.ids) > 0 ? 0 : 1
  vpc_id       = data.alicloud_vpcs.default.ids.0
  cidr_block   = cidrsubnet(data.alicloud_vpcs.default.vpcs[0].cidr_block, 8, 8)
  zone_id      = var.zone_id
  vswitch_name = var.name
}

locals {
  vswitch_id = length(data.alicloud_vswitches.default.ids) > 0 ? data.alicloud_vswitches.default.ids[0] : concat(alicloud_vswitch.vswitch.*.id, [""])[0]
}

resource "alicloud_kvstore_instance" "default" {
  port           = "6379"
  payment_type   = "PrePaid"
  instance_type  = "Redis"
  password       = "123456_tf"
  engine_version = "5.0"
  zone_id        = var.zone_id
  vswitch_id     = local.vswitch_id
  period         = "1"
  instance_class = "redis.shard.small.2.ce"
}

resource "alicloud_redis_backup" "default" {
  instance_id             = alicloud_kvstore_instance.default.id
  backup_retention_period = 7
}
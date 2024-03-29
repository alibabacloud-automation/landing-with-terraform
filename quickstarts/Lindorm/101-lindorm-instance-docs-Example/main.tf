provider "alicloud" {
  region = local.region
}

variable "name" {
  default = "tf-example"
}

locals {
  region  = "cn-hangzhou"
  zone_id = "cn-hangzhou-h"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}

data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = local.zone_id
}

resource "alicloud_lindorm_instance" "default" {
  disk_category              = "cloud_efficiency"
  payment_type               = "PayAsYouGo"
  zone_id                    = local.zone_id
  vswitch_id                 = data.alicloud_vswitches.default.ids.0
  vpc_id                     = data.alicloud_vpcs.default.ids.0
  instance_name              = var.name
  table_engine_specification = "lindorm.g.4xlarge"
  table_engine_node_count    = "2"
  instance_storage           = "1920"
}
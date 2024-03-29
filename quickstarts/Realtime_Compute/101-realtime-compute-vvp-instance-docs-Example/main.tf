variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}

data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = "cn-hangzhou-h"
}

resource "alicloud_oss_bucket" "defaultOSS" {
  bucket = "${var.name}-${random_integer.default.result}"
}

data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}

resource "alicloud_realtime_compute_vvp_instance" "default" {
  storage {
    oss {
      bucket = alicloud_oss_bucket.defaultOSS.bucket
    }
  }

  vvp_instance_name = "${var.name}-${random_integer.default.result}"
  vpc_id            = data.alicloud_vpcs.default.ids.0
  zone_id           = "cn-hangzhou-h"
  vswitch_ids = [
    "${data.alicloud_vswitches.default.ids.0}"
  ]
  payment_type = "PayAsYouGo"
}
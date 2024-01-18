variable "name" {
  default = "terraform-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

locals {
  name = "${var.name}-${random_integer.default.result}"
}

data "alicloud_regions" "default" {
  current = true
}

data "alicloud_account" "default" {
}

data "alicloud_zones" "default" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "default" {
  vpc_name   = local.name
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_zones.default.zones[0].id
  vswitch_name = local.name
}

resource "alicloud_ess_scaling_group" "default" {
  min_size           = 1
  max_size           = 1
  scaling_group_name = local.name
  removal_policies   = ["OldestInstance", "NewestInstance"]
  vswitch_ids        = [alicloud_vswitch.default.id]
}

resource "alicloud_mns_queue" "default" {
  name = local.name
}

resource "alicloud_ess_notification" "default" {
  scaling_group_id   = alicloud_ess_scaling_group.default.id
  notification_types = ["AUTOSCALING:SCALE_OUT_SUCCESS", "AUTOSCALING:SCALE_OUT_ERROR"]
  notification_arn   = "acs:ess:${data.alicloud_regions.default.regions[0].id}:${data.alicloud_account.default.id}:queue/${alicloud_mns_queue.default.name}"
}
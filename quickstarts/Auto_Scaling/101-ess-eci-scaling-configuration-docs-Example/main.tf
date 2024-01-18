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

resource "alicloud_security_group" "default" {
  name   = local.name
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_ess_scaling_group" "default" {
  min_size           = 0
  max_size           = 1
  scaling_group_name = local.name
  removal_policies   = ["OldestInstance", "NewestInstance"]
  vswitch_ids        = [alicloud_vswitch.default.id]
  group_type         = "ECI"
}

resource "alicloud_ess_eci_scaling_configuration" "default" {
  scaling_group_id     = alicloud_ess_scaling_group.default.id
  cpu                  = 2
  memory               = 4
  security_group_id    = alicloud_security_group.default.id
  force_delete         = true
  active               = true
  container_group_name = "container-group-1649839595174"
  containers {
    name  = "container-1"
    image = "registry-vpc.cn-hangzhou.aliyuncs.com/eci_open/alpine:3.5"
  }
}
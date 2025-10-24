provider "alicloud" {
  region = "cn-hangzhou"
}
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
data "alicloud_instance_types" "default1" {
  availability_zone = data.alicloud_zones.default.zones.0.id
}
resource "alicloud_vswitch" "default" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_zones.default.zones[0].id
  vswitch_name = local.name
}

resource "alicloud_security_group" "default" {
  security_group_name = local.name
  vpc_id              = alicloud_vpc.default.id
}
data "alicloud_images" "default1" {
  name_regex  = "^ubu"
  most_recent = true
  owners      = "system"
}
data "alicloud_images" "default2" {
  name_regex  = "^aliyun"
  most_recent = true
  owners      = "system"
}
resource "alicloud_ess_scaling_group" "default" {
  min_size           = 0
  max_size           = 10
  scaling_group_name = local.name
  removal_policies   = ["OldestInstance", "NewestInstance"]
  vswitch_ids        = [alicloud_vswitch.default.id]
  desired_capacity   = 1
}

resource "alicloud_ess_scaling_configuration" "default" {
  scaling_group_id  = alicloud_ess_scaling_group.default.id
  image_id          = data.alicloud_images.default1.images[0].id
  instance_type     = data.alicloud_instance_types.default1.instance_types.0.id
  security_group_id = alicloud_security_group.default.id
  force_delete      = true
  active            = true
  enable            = true
}

resource "alicloud_ess_instance_refresh" "default" {
  scaling_group_id               = alicloud_ess_scaling_configuration.default.scaling_group_id
  desired_configuration_image_id = data.alicloud_images.default2.images.0.id
  min_healthy_percentage         = 90
  max_healthy_percentage         = 150
  checkpoint_pause_time          = 60
  skip_matching                  = false
  checkpoints {
    percentage = 100
  }
}
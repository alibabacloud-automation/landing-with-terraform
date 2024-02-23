variable "name" {
  default = "tf-example"
}
provider "alicloud" {
  region = "cn-hangzhou"
}
locals {
  zone_id = "cn-hangzhou-i"
}
data "alicloud_instance_types" "example" {
  availability_zone    = local.zone_id
  instance_type_family = "ecs.g7se"
}
data "alicloud_images" "example" {
  instance_type = data.alicloud_instance_types.example.instance_types[length(data.alicloud_instance_types.example.instance_types) - 1].id
  name_regex    = "^aliyun_2_1903_x64_20G_alibase_20231221.vhd"
  owners        = "system"
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}
data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids[0]
  zone_id = local.zone_id
}

resource "alicloud_security_group" "example" {
  name   = var.name
  vpc_id = data.alicloud_vpcs.default.ids[0]
}

resource "alicloud_instance" "default" {
  availability_zone    = local.zone_id
  instance_name        = var.name
  image_id             = data.alicloud_images.example.images.0.id
  instance_type        = data.alicloud_instance_types.example.instance_types[length(data.alicloud_instance_types.example.instance_types) - 1].id
  security_groups      = [alicloud_security_group.example.id]
  vswitch_id           = data.alicloud_vswitches.default.ids.0
  system_disk_category = "cloud_essd"
}
resource "alicloud_dbfs_instance" "default" {
  category          = "enterprise"
  zone_id           = alicloud_instance.default.availability_zone
  performance_level = "PL1"
  fs_name           = var.name
  size              = 100
}
resource "alicloud_dbfs_instance_attachment" "example" {
  ecs_id      = alicloud_instance.default.id
  instance_id = alicloud_dbfs_instance.default.id
}

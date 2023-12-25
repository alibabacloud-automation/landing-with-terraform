data "alicloud_resource_manager_resource_groups" "default" {
  name_regex = "default"
}
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}
data "alicloud_images" "default" {
  name_regex  = "^ubuntu_[0-9]+_[0-9]+_x64*"
  most_recent = true
  owners      = "system"
}
data "alicloud_instance_types" "default" {
  image_id = data.alicloud_images.default.ids.0
}
data "alicloud_account" "default" {
}
resource "alicloud_vpc" "default" {
  vpc_name   = "terraform-example"
  cidr_block = "172.17.3.0/24"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = "terraform-example"
  cidr_block   = "172.17.3.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_zones.default.zones.0.id
}
resource "alicloud_ecs_image_pipeline" "default" {
  add_account                = [data.alicloud_account.default.id]
  base_image                 = data.alicloud_images.default.ids.0
  base_image_type            = "IMAGE"
  build_content              = "RUN yum update -y"
  delete_instance_on_failure = false
  image_name                 = "terraform-example"
  name                       = "terraform-example"
  description                = "terraform-example"
  instance_type              = data.alicloud_instance_types.default.ids.0
  resource_group_id          = data.alicloud_resource_manager_resource_groups.default.groups.0.id
  internet_max_bandwidth_out = 20
  system_disk_size           = 40
  to_region_id               = ["cn-qingdao", "cn-zhangjiakou"]
  vswitch_id                 = alicloud_vswitch.default.id
  tags = {
    Created = "TF"
    For     = "Acceptance-test"
  }
}
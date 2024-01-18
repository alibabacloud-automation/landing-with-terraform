data "alicloud_zones" "default" {
  available_resource_creation = "Instance"
}

data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.sn1ne"
}

data "alicloud_images" "default" {
  name_regex = "^ubuntu_[0-9]+_[0-9]+_x64*"
  owners     = "system"
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

resource "alicloud_security_group" "default" {
  name   = "terraform-example"
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_instance" "default" {
  availability_zone          = data.alicloud_zones.default.zones.0.id
  instance_name              = "terraform-example"
  security_groups            = [alicloud_security_group.default.id]
  vswitch_id                 = alicloud_vswitch.default.id
  instance_type              = data.alicloud_instance_types.default.ids[0]
  image_id                   = data.alicloud_images.default.ids[0]
  internet_max_bandwidth_out = 10
}

resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_image" "default" {
  instance_id = alicloud_instance.default.id
  image_name  = "terraform-example-${random_integer.default.result}"
  description = "terraform-example"
}

resource "alicloud_oss_bucket" "default" {
  bucket = "example-value-${random_integer.default.result}"
}

resource "alicloud_image_export" "default" {
  image_id   = alicloud_image.default.id
  oss_bucket = alicloud_oss_bucket.default.id
  oss_prefix = "ecsExport"
}
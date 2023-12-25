provider "alicloud" {
  alias  = "sh"
  region = "cn-shanghai"
}
provider "alicloud" {
  alias  = "hz"
  region = "cn-hangzhou"
}

data "alicloud_zones" "default" {
  provider                    = alicloud.hz
  available_resource_creation = "Instance"
}

data "alicloud_instance_types" "default" {
  provider             = alicloud.hz
  instance_type_family = "ecs.sn1ne"
}

data "alicloud_images" "default" {
  provider   = alicloud.hz
  name_regex = "^ubuntu_[0-9]+_[0-9]+_x64*"
  owners     = "system"
}

resource "alicloud_vpc" "default" {
  provider   = alicloud.hz
  vpc_name   = "terraform-example"
  cidr_block = "172.17.3.0/24"
}

resource "alicloud_vswitch" "default" {
  provider     = alicloud.hz
  vswitch_name = "terraform-example"
  cidr_block   = "172.17.3.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "default" {
  provider = alicloud.hz
  name     = "terraform-example"
  vpc_id   = alicloud_vpc.default.id
}

resource "alicloud_instance" "default" {
  provider                   = alicloud.hz
  availability_zone          = data.alicloud_zones.default.zones.0.id
  instance_name              = "terraform-example"
  security_groups            = [alicloud_security_group.default.id]
  vswitch_id                 = alicloud_vswitch.default.id
  instance_type              = data.alicloud_instance_types.default.ids[0]
  image_id                   = data.alicloud_images.default.ids[0]
  internet_max_bandwidth_out = 10
}

resource "alicloud_image" "default" {
  provider    = alicloud.hz
  instance_id = alicloud_instance.default.id
  image_name  = "terraform-example"
  description = "terraform-example"
}

resource "alicloud_image_copy" "default" {
  provider         = alicloud.sh
  source_image_id  = alicloud_image.default.id
  source_region_id = "cn-hangzhou"
  image_name       = "terraform-example"
  description      = "terraform-example"
  tags = {
    FinanceDept = "FinanceDeptJoshua"
  }
}
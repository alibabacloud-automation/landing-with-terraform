data "alicloud_zones" "example" {
  available_resource_creation = "Instance"
}

data "alicloud_instance_types" "example" {
  availability_zone = data.alicloud_zones.example.zones.0.id
  cpu_core_count    = 1
  memory_size       = 2
}

data "alicloud_images" "example" {
  name_regex = "^ubuntu_[0-9]+_[0-9]+_x64*"
  owners     = "system"
}

resource "alicloud_vpc" "example" {
  vpc_name   = "terraform-example"
  cidr_block = "172.17.3.0/24"
}

resource "alicloud_vswitch" "example" {
  vswitch_name = "terraform-example"
  cidr_block   = "172.17.3.0/24"
  vpc_id       = alicloud_vpc.example.id
  zone_id      = data.alicloud_zones.example.zones.0.id
}

resource "alicloud_security_group" "example" {
  name   = "terraform-example"
  vpc_id = alicloud_vpc.example.id
}

resource "alicloud_instance" "example" {
  image_id             = data.alicloud_images.example.images.0.id
  instance_type        = data.alicloud_instance_types.example.instance_types.0.id
  availability_zone    = data.alicloud_zones.example.zones.0.id
  security_groups      = [alicloud_security_group.example.id]
  instance_name        = "terraform-example"
  internet_charge_type = "PayByBandwidth"
  vswitch_id           = alicloud_vswitch.example.id
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_ecs_key_pair" "example" {
  key_pair_name = "tf-example-${random_integer.default.result}"
}

resource "alicloud_ecs_key_pair_attachment" "example" {
  key_pair_name = alicloud_ecs_key_pair.example.key_pair_name
  instance_ids  = [alicloud_instance.example.id]
}
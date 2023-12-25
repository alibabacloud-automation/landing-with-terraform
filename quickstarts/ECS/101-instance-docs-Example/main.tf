variable "name" {
  default = "terraform-example"
}

# Create a new ECS instance for a VPC
resource "alicloud_security_group" "group" {
  name        = var.name
  description = "foo"
  vpc_id      = alicloud_vpc.vpc.id
}

resource "alicloud_kms_key" "key" {
  description            = "Hello KMS"
  pending_window_in_days = "7"
  status                 = "Enabled"
}

data "alicloud_zones" "default" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
}

# Create a new ECS instance for VPC
resource "alicloud_vpc" "vpc" {
  vpc_name   = var.name
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = var.name
}

resource "alicloud_instance" "instance" {
  # cn-beijing
  availability_zone = data.alicloud_zones.default.zones.0.id
  security_groups   = alicloud_security_group.group.*.id

  # series III
  instance_type              = "ecs.n4.large"
  system_disk_category       = "cloud_efficiency"
  system_disk_name           = var.name
  system_disk_description    = "test_foo_system_disk_description"
  image_id                   = "ubuntu_18_04_64_20G_alibase_20190624.vhd"
  instance_name              = var.name
  vswitch_id                 = alicloud_vswitch.vswitch.id
  internet_max_bandwidth_out = 10
  data_disks {
    name        = "disk2"
    size        = 20
    category    = "cloud_efficiency"
    description = "disk2"
    encrypted   = true
    kms_key_id  = alicloud_kms_key.key.id
  }
}
# Create a new ECS disk-attachment and use it attach one disk to a new instance.
variable "name" {
  default = "tf-example"
}

data "alicloud_zones" "default" {
  available_resource_creation = "Instance"
}

data "alicloud_instance_types" "default" {
  availability_zone    = data.alicloud_zones.default.zones.0.id
  instance_type_family = "ecs.sn1ne"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vpc_id     = alicloud_vpc.default.id
  cidr_block = "10.4.0.0/24"
  zone_id    = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "default" {
  name        = "tf-example"
  description = "New security group"
  vpc_id      = alicloud_vpc.default.id
}

data "alicloud_images" "default" {
  name_regex  = "^ubuntu_[0-9]+_[0-9]+_x64*"
  most_recent = true
  owners      = "system"
}
resource "alicloud_instance" "default" {
  availability_zone = data.alicloud_zones.default.zones.0.id
  instance_name     = var.name
  host_name         = var.name
  image_id          = data.alicloud_images.default.images.0.id
  instance_type     = data.alicloud_instance_types.default.instance_types.0.id
  security_groups   = [alicloud_security_group.default.id]
  vswitch_id        = alicloud_vswitch.default.id
}

data "alicloud_zones" "disk" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_ecs_disk" "default" {
  zone_id              = data.alicloud_zones.disk.zones.0.id
  category             = "cloud_efficiency"
  delete_auto_snapshot = "true"
  description          = "Test For Terraform"
  disk_name            = var.name
  enable_auto_snapshot = "true"
  encrypted            = "true"
  size                 = "500"
  tags = {
    Created     = "TF"
    Environment = "Acceptance-test"
  }
}

resource "alicloud_ecs_disk_attachment" "default" {
  disk_id     = alicloud_ecs_disk.default.id
  instance_id = alicloud_instance.default.id
}
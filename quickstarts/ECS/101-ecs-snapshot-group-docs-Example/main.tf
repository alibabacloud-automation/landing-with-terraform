data "alicloud_zones" "default" {
  available_resource_creation = "Instance"
  available_disk_category     = "cloud_essd"
}
data "alicloud_instance_types" "default" {
  availability_zone    = data.alicloud_zones.default.zones.0.id
  system_disk_category = "cloud_essd"
}
data "alicloud_images" "default" {
  owners      = "system"
  name_regex  = "^ubuntu_18.*64"
  most_recent = true
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
  instance_type              = data.alicloud_instance_types.default.instance_types.0.id
  image_id                   = data.alicloud_images.default.images.0.id
  internet_max_bandwidth_out = 10
}

resource "alicloud_ecs_disk" "default" {
  zone_id     = data.alicloud_zones.default.zones.0.id
  disk_name   = "terraform-example"
  description = "terraform-example"
  category    = "cloud_essd"
  size        = "30"
}

resource "alicloud_disk_attachment" "default" {
  disk_id     = alicloud_ecs_disk.default.id
  instance_id = alicloud_instance.default.id
}

resource "alicloud_ecs_snapshot_group" "default" {
  description                   = "terraform-example"
  disk_id                       = [alicloud_disk_attachment.default.disk_id]
  snapshot_group_name           = "terraform-example"
  instance_id                   = alicloud_instance.default.id
  instant_access                = true
  instant_access_retention_days = 1
  tags = {
    Created = "TF"
    For     = "Acceptance"
  }
}
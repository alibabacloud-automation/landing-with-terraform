variable "name" {
  default = "tf-example"
}
provider "alicloud" {
  region = "cn-hangzhou"
}
data "alicloud_regions" "default" {
  current = true
}
data "alicloud_ebs_regions" "default" {
  region_id = data.alicloud_regions.default.regions.0.id
}

resource "alicloud_ecs_disk" "default" {
  zone_id              = data.alicloud_ebs_regions.default.regions[0].zones[0].zone_id
  category             = "cloud_essd"
  delete_auto_snapshot = "true"
  delete_with_instance = "true"
  description          = var.name
  disk_name            = var.name
  enable_auto_snapshot = "true"
  encrypted            = "true"
  size                 = "500"
  tags = {
    Created      = "TF",
    For          = "example",
    controlledBy = "ear"
  }
}

resource "alicloud_ecs_disk" "destination" {
  zone_id              = data.alicloud_ebs_regions.default.regions[0].zones[1].zone_id
  category             = "cloud_essd"
  delete_auto_snapshot = "true"
  delete_with_instance = "true"
  description          = format("%s-destination", var.name)
  disk_name            = var.name
  enable_auto_snapshot = "true"
  encrypted            = "true"
  size                 = "500"
  tags = {
    Created      = "TF",
    For          = "example",
    controlledBy = "ear"
  }
}

resource "alicloud_ebs_disk_replica_pair" "default" {
  destination_disk_id   = alicloud_ecs_disk.destination.id
  destination_region_id = data.alicloud_regions.default.regions.0.id
  payment_type          = "POSTPAY"
  destination_zone_id   = alicloud_ecs_disk.destination.zone_id
  source_zone_id        = alicloud_ecs_disk.default.zone_id
  disk_id               = alicloud_ecs_disk.default.id
  description           = var.name
}
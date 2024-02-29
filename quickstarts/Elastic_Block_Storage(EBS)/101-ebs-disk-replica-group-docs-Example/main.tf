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

resource "alicloud_ebs_disk_replica_group" "default" {
  source_region_id      = data.alicloud_regions.default.regions.0.id
  source_zone_id        = data.alicloud_ebs_regions.default.regions[0].zones[0].zone_id
  destination_region_id = data.alicloud_regions.default.regions.0.id
  destination_zone_id   = data.alicloud_ebs_regions.default.regions[0].zones[1].zone_id
  group_name            = var.name
  description           = var.name
  rpo                   = 900
}
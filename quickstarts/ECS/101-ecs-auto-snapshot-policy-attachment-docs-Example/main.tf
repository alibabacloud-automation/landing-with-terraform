variable "name" {
  default = "terraform-example"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_ecs_auto_snapshot_policy" "default" {
  auto_snapshot_policy_name = var.name
  repeat_weekdays           = ["1", "2", "3"]
  retention_days            = 1
  time_points               = ["1", "2", "3"]
}

resource "alicloud_ecs_disk" "default" {
  zone_id = data.alicloud_zones.default.zones.0.id
  size    = "500"
}

resource "alicloud_ecs_auto_snapshot_policy_attachment" "default" {
  auto_snapshot_policy_id = alicloud_ecs_auto_snapshot_policy.default.id
  disk_id                 = alicloud_ecs_disk.default.id
}
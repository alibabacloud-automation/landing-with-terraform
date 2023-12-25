data "alicloud_zones" "example" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_kms_key" "example" {
  description            = "terraform-example"
  pending_window_in_days = "7"
  status                 = "Enabled"
}

resource "alicloud_ecs_auto_snapshot_policy" "example" {
  name            = "terraform-example"
  repeat_weekdays = ["1", "2", "3"]
  retention_days  = -1
  time_points     = ["1", "22", "23"]
}

resource "alicloud_ecs_disk" "example" {
  zone_id     = data.alicloud_zones.example.zones.0.id
  disk_name   = "terraform-example"
  description = "Hello ecs disk."
  category    = "cloud_efficiency"
  size        = "30"
  encrypted   = true
  kms_key_id  = alicloud_kms_key.example.id
  tags = {
    Name = "terraform-example"
  }
}

resource "alicloud_ecs_auto_snapshot_policy_attachment" "example" {
  auto_snapshot_policy_id = alicloud_ecs_auto_snapshot_policy.example.id
  disk_id                 = alicloud_ecs_disk.example.id
}
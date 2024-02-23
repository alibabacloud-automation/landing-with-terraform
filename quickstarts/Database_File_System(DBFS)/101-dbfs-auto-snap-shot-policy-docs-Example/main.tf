provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_dbfs_auto_snap_shot_policy" "default" {
  time_points     = ["01"]
  policy_name     = "tf-example"
  retention_days  = 1
  repeat_weekdays = ["2"]
}
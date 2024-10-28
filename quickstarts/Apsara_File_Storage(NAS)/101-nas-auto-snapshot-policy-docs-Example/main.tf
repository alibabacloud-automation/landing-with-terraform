variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_nas_auto_snapshot_policy" "default" {
  time_points               = ["0", "1", "2"]
  retention_days            = "1"
  repeat_weekdays           = ["2", "3", "4"]
  auto_snapshot_policy_name = var.name
  file_system_type          = "extreme"
}
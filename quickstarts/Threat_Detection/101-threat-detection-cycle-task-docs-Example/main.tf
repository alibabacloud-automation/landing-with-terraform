variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_threat_detection_cycle_task" "default" {
  target_end_time   = "6"
  task_type         = "VIRUS_VUL_SCHEDULE_SCAN"
  target_start_time = "0"
  source            = "console_batch"
  task_name         = "VIRUS_VUL_SCHEDULE_SCAN"
  first_date_str    = "1650556800000"
  period_unit       = "day"
  interval_period   = "7"
  param             = jsonencode({ "targetInfo" : [{ "type" : "groupId", "name" : "TI HOST", "target" : 10597 }, { "type" : "groupId", "name" : "expense HOST", "target" : 10597 }] })
  enable            = "1"
}
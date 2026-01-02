resource "alicloud_threat_detection_check_config" "default" {
  end_time          = "18"
  enable_auto_check = true
  vendors           = ["ALIYUN"]
  cycle_days        = ["7", "1", "2"]
  enable_add_check  = true
  start_time        = "12"
  configure         = "not"
  system_config     = false
  selected_checks {
    check_id   = 370
    section_id = 515
  }
}
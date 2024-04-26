resource "alicloud_threat_detection_baseline_strategy" "default" {
  custom_type            = "custom"
  end_time               = "08:00:00"
  baseline_strategy_name = "apispec"
  cycle_days             = 3
  target_type            = "groupId"
  start_time             = "05:00:00"
  risk_sub_type_name     = "hc_exploit_redis"
}
variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_cloud_monitor_service_metric_alarm_rule" "default" {
  status               = true
  send_ok              = true
  contact_groups       = "云账号报警联系人"
  silence_time         = "86400"
  metric_alarm_rule_id = "SystemDefault_acs_drds_IOPSUsageOfDo"
  period               = "60"
  effective_interval   = "00:00-23:59 +0800 dayofweek 1,2,3,4,5,6,7"
  no_data_policy       = "KEEP_LAST_STATE"
  namespace            = "acs_drds"
  metric_name          = "IOPSUsageOfDN"
  escalations {
    critical {
      comparison_operator = "GreaterThanThreshold"
      times               = "5"
      statistics          = "Average"
      threshold           = "80"
    }
  }
  resources = jsonencode([{ resource = "_ALL" }])
  rule_name = "SystemDefault_acs_drds_IOPSUsageOfDN"
}
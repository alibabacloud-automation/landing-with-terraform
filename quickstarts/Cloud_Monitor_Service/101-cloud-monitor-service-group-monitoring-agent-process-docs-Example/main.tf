variable "name" {
  default = "terraform-example"
}

resource "alicloud_cms_alarm_contact_group" "default" {
  alarm_contact_group_name = var.name
  contacts                 = ["user", "user1", "user2"]
}

resource "alicloud_cms_monitor_group" "default" {
  monitor_group_name = var.name
  contact_groups     = [alicloud_cms_alarm_contact_group.default.id]
}

resource "alicloud_cloud_monitor_service_group_monitoring_agent_process" "default" {
  group_id                      = alicloud_cms_monitor_group.default.id
  process_name                  = var.name
  match_express_filter_relation = "or"
  match_express {
    name     = var.name
    value    = "*"
    function = "all"
  }
  alert_config {
    escalations_level   = "critical"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    statistics          = "Average"
    threshold           = "20"
    times               = "100"
    effective_interval  = "00:00-22:59"
    silence_time        = "85800"
    webhook             = "https://www.aliyun.com"
    target_list {
      target_list_id = "1"
      json_params    = "{}"
      level          = "WARN"
      arn            = "acs:mns:cn-hangzhou:120886317861****:/queues/test123/message"
    }
  }
}
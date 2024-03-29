variable "name" {
  default = "tf-example"
}

resource "alicloud_cms_alarm_contact_group" "default" {
  alarm_contact_group_name = var.name
  describe                 = var.name
}

resource "alicloud_cms_monitor_group" "default" {
  monitor_group_name = var.name
  contact_groups     = [alicloud_cms_alarm_contact_group.default.id]
}

resource "alicloud_cms_group_metric_rule" "this" {
  group_id               = alicloud_cms_monitor_group.default.id
  group_metric_rule_name = var.name
  category               = "ecs"
  metric_name            = "cpu_total"
  namespace              = "acs_ecs_dashboard"
  rule_id                = var.name
  period                 = "60"
  interval               = "3600"
  silence_time           = 85800
  no_effective_interval  = "00:00-05:30"
  webhook                = "http://www.aliyun.com"
  escalations {
    warn {
      comparison_operator = "GreaterThanOrEqualToThreshold"
      statistics          = "Average"
      threshold           = "90"
      times               = 3
    }
    info {
      comparison_operator = "LessThanLastWeek"
      statistics          = "Average"
      threshold           = "90"
      times               = 5
    }
  }
}
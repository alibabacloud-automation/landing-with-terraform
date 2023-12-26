variable "name" {
  default = "tf-example"
}

resource "alicloud_cms_monitor_group" "default" {
  monitor_group_name = var.name
}

resource "alicloud_cms_event_rule" "example" {
  rule_name    = var.name
  group_id     = alicloud_cms_monitor_group.default.id
  silence_time = 100
  description  = var.name
  status       = "ENABLED"
  event_pattern {
    product         = "ecs"
    sql_filter      = "example_value"
    name_list       = ["example_value"]
    level_list      = ["CRITICAL"]
    event_type_list = ["StatusNotification"]
  }
}
resource "alicloud_cloud_firewall_user_alarm_config" "default" {
  alarm_config {
    alarm_value    = "on"
    alarm_type     = "bandwidth"
    alarm_period   = "1"
    alarm_hour     = "0"
    alarm_notify   = "0"
    alarm_week_day = "0"
  }
  use_default_contact = "1"
  notify_config {
    notify_value = "13000000000"
    notify_type  = "sms"
  }
  alarm_lang = "zh"
  lang       = "zh"
}
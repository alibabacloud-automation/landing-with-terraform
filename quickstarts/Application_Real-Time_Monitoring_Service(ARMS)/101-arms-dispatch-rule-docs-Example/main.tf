resource "alicloud_arms_alert_contact" "default" {
  alert_contact_name = "example_value"
  email              = "example_value@aaa.com"
}
resource "alicloud_arms_alert_contact_group" "default" {
  alert_contact_group_name = "example_value"
  contact_ids              = [alicloud_arms_alert_contact.default.id]
}

resource "alicloud_arms_dispatch_rule" "default" {
  dispatch_rule_name = "example_value"
  dispatch_type      = "CREATE_ALERT"
  group_rules {
    group_wait_time = 5
    group_interval  = 15
    repeat_interval = 100
    grouping_fields = ["alertname"]
  }
  label_match_expression_grid {
    label_match_expression_groups {
      label_match_expressions {
        key      = "_aliyun_arms_involvedObject_kind"
        value    = "app"
        operator = "eq"
      }
    }
  }

  notify_rules {
    notify_objects {
      notify_object_id = alicloud_arms_alert_contact.default.id
      notify_type      = "ARMS_CONTACT"
      name             = "example_value"
    }
    notify_objects {
      notify_object_id = alicloud_arms_alert_contact_group.default.id
      notify_type      = "ARMS_CONTACT_GROUP"
      name             = "example_value"
    }
    notify_channels   = ["dingTalk", "wechat"]
    notify_start_time = "10:00"
    notify_end_time   = "23:00"
  }

  notify_template {
    email_title           = "example_email_title"
    email_content         = "example_email_content"
    email_recover_title   = "example_email_recover_title"
    email_recover_content = "example_email_recover_content"
    sms_content           = "example_sms_content"
    sms_recover_content   = "example_sms_recover_content"
    tts_content           = "example_tts_content"
    tts_recover_content   = "example_tts_recover_content"
    robot_content         = "example_robot_content"
  }
}
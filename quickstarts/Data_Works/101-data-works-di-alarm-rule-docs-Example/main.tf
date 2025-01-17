variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-chengdu"
}

resource "alicloud_data_works_project" "defaulteNv8bu" {
  project_name = var.name
  display_name = var.name
  description  = var.name
}

resource "alicloud_data_works_di_job" "defaultUW8inp" {
  description             = "xxxx"
  project_id              = alicloud_data_works_project.defaulteNv8bu.id
  job_name                = "xxx"
  migration_type          = "api_xxx"
  source_data_source_type = "xxx"
  resource_settings {
    offline_resource_settings {
      requested_cu              = 2
      resource_group_identifier = "xx"
    }
    realtime_resource_settings {
      requested_cu              = 2
      resource_group_identifier = "xx"
    }
    schedule_resource_settings {
      requested_cu              = 2
      resource_group_identifier = "xx"
    }
  }
  job_settings {
    channel_settings = "xxxx"
    column_data_type_settings {
      destination_data_type = "xxxx"
      source_data_type      = "xxxx"
    }
    cycle_schedule_settings {
      cycle_migration_type = "xxxx"
      schedule_parameters  = "xxxx"
    }
  }
  source_data_source_settings {
    data_source_name = "xxxx"
    data_source_properties {
      encoding = "xxxx"
      timezone = "xxxx"
    }
  }
  destination_data_source_type = "xxxx"
  table_mappings {
    source_object_selection_rules {
      action          = "Include"
      expression      = "xxxx"
      expression_type = "Exact"
      object_type     = "xxxx"
    }
    source_object_selection_rules {
      action          = "Include"
      expression      = "xxxx"
      expression_type = "Exact"
      object_type     = "xxxx"
    }
    transformation_rules {
      rule_name        = "xxxx"
      rule_action_type = "xxxx"
      rule_target_type = "xxxx"
    }
  }
  transformation_rules {
    rule_action_type = "xxxx"
    rule_expression  = "xxxx"
    rule_name        = "xxxx"
    rule_target_type = "xxxx"
  }
  destination_data_source_settings {
    data_source_name = "xxx"
  }
}


resource "alicloud_data_works_di_alarm_rule" "default" {
  description = "Description"
  trigger_conditions {
    ddl_report_tags = ["ALTERADDCOLUMN"]
    threshold       = "20"
    duration        = "10"
    severity        = "Warning"
  }
  metric_type = "DdlReport"
  notification_settings {
    notification_channels {
      severity = "Warning"
      channels = ["Ding"]
    }
    notification_receivers {
      receiver_type   = "DingToken"
      receiver_values = ["1107550004253538"]
    }
    inhibition_interval = "10"
  }
  di_job_id          = alicloud_data_works_di_job.defaultUW8inp.di_job_id
  di_alarm_rule_name = var.name
}
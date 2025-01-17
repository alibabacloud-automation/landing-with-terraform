variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-chengdu"
}

resource "alicloud_data_works_project" "defaultMMHL8U" {
  description  = var.name
  project_name = var.name
  display_name = var.name
}


resource "alicloud_data_works_di_job" "default" {
  description    = var.name
  project_id     = alicloud_data_works_project.defaultMMHL8U.id
  job_name       = "zhenyuan_example_case"
  migration_type = "api_FullAndRealtimeIncremental"
  source_data_source_settings {
    data_source_name = "dw_mysql"
    data_source_properties {
      encoding = "utf-8"
      timezone = "Asia/Shanghai"
    }
  }
  destination_data_source_type = "Hologres"
  table_mappings {
    source_object_selection_rules {
      action          = "Include"
      expression      = "dw_mysql"
      expression_type = "Exact"
      object_type     = "Datasource"
    }
    source_object_selection_rules {
      action          = "Include"
      expression      = "example_db1"
      expression_type = "Exact"
      object_type     = "Database"
    }
    source_object_selection_rules {
      action          = "Include"
      expression      = "lsc_example01"
      expression_type = "Exact"
      object_type     = "Table"
    }
    transformation_rules {
      rule_name        = "my_table_rename_rule"
      rule_action_type = "Rename"
      rule_target_type = "Table"
    }
  }
  source_data_source_type = "MySQL"
  resource_settings {
    offline_resource_settings {
      requested_cu              = 2
      resource_group_identifier = "S_res_group_524257424564736_1716799673667"
    }
    realtime_resource_settings {
      requested_cu              = 2
      resource_group_identifier = "S_res_group_524257424564736_1716799673667"
    }
    schedule_resource_settings {
      requested_cu              = 2
      resource_group_identifier = "S_res_group_524257424564736_1716799673667"
    }
  }
  transformation_rules {
    rule_action_type = "Rename"
    rule_expression  = "{\"expression\":\"table2\"}"
    rule_name        = "my_table_rename_rule"
    rule_target_type = "Table"
  }
  destination_data_source_settings {
    data_source_name = "dw_example_holo"
  }
  job_settings {
    column_data_type_settings {
      destination_data_type = "bigint"
      source_data_type      = "longtext"
    }
    ddl_handling_settings {
      action = "Ignore"
      type   = "CreateTable"
    }
    runtime_settings {
      name  = "runtime.realtime.concurrent"
      value = "1"
    }
    channel_settings = "1"
    cycle_schedule_settings {
      cycle_migration_type = "2"
      schedule_parameters  = "3"
    }
  }
}
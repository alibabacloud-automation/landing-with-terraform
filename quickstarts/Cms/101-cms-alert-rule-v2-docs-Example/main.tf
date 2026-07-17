variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_cms_alert_rule_v2" "default" {
  content_template = "umodel example alert on $${metric}"
  schedule_config {
    type          = "FIXED"
    interval_secs = "60"
  }
  datasource_config {
    type = "UMODEL"
  }
  action_integration_config {
    enabled = false
  }
  arms_integration_config {
    enabled = false
  }
  query_config {
    entity_type   = "instance"
    type          = "UMODEL_METRICSET_QUERY"
    entity_domain = "ecs"
    metric        = "CPUUtilization"
    label_filters {
      operator = "="
      value    = "web-server"
      name     = "app"
    }
    label_filters {
      operator = "="
      value    = "production"
      name     = "env"
    }
    metric_set = "acs_ecs_dashboard"
  }
  display_name = "regression-umodel-10"
  enabled      = true
  notify_config {
    type = "DIRECT_NOTIFY"
    channels {
      type        = "GROUP"
      identifiers = ["regression-example"]
    }
  }
  condition_config {
    operator      = "GT"
    type          = "UMODEL_METRICSET_CONDITION"
    severity      = "CRITICAL"
    duration_secs = "60"
    threshold     = 90
  }
}
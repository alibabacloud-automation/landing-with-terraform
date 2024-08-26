variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "alert_name" {
  default = "openapi-terraform-alert"
}

variable "project_name" {
  default = "terraform-alert-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_log_project" "defaultINsMgl" {
  description  = "${var.project_name}-${random_integer.default.result}"
  project_name = "${var.project_name}-${random_integer.default.result}"
}

resource "alicloud_sls_alert" "default" {
  schedule {
    type           = "FixedRate"
    run_immdiately = "true"
    interval       = "1m"
    time_zone      = "+0800"
    delay          = "10"
  }

  display_name = "openapi-terraform"
  description  = "create alert"
  status       = "ENABLED"
  configuration {
    group_configuration {
      fields = [
        "a",
        "b"
      ]
      type = "no_group"
    }

    no_data_fire = "false"
    version      = "2"
    severity_configurations {
      severity = "6"
      eval_condition {
        count_condition = "cnt > 0"
        condition       = "__count__ > 1"
      }

    }

    labels {
      key   = "a"
      value = "b"
    }

    auto_annotation = "true"
    template_configuration {
      lang = "cn"
      tokens = {
        "a" = "b"
      }
      annotations = {
        "x" = "y"
      }
      template_id = "sls.app.ack.autoscaler.cluster_unhealthy"
      type        = "sys"
      version     = "1.0"
    }

    mute_until = "0"
    annotations {
      key   = "x"
      value = "y"
    }

    send_resolved = "false"
    threshold     = "1"
    sink_cms {
      enabled = "false"
    }

    condition_configuration {
      condition       = "cnt > 3"
      count_condition = "__count__ < 3"
    }

    policy_configuration {
      alert_policy_id  = "sls.builtin.dynamic"
      action_policy_id = "wkb-action"
      repeat_interval  = "1m"
    }

    dashboard = "internal-alert"
    type      = "tpl"
    query_list {
      ui             = "{}"
      role_arn       = "acs:ram::1654218965343050:role/aliyunslsalertmonitorrole"
      query          = "* | select *"
      time_span_type = "Relative"
      project        = alicloud_log_project.defaultINsMgl.project_name
      power_sql_mode = "disable"
      dashboard_id   = "wkb-dashboard"
      chart_title    = "wkb-chart"
      start          = "-15m"
      end            = "now"
      store_type     = "log"
      store          = "alert"
      region         = "cn-shanghai"
    }
    query_list {
      store_type = "meta"
      store      = "user.rds_ip_whitelist"
    }
    query_list {
      store_type = "meta"
      store      = "myexample1"
    }

    join_configurations {
      type      = "no_join"
      condition = "aa"
    }
    join_configurations {
      type      = "cross_join"
      condition = "qqq"
    }
    join_configurations {
      type      = "inner_join"
      condition = "fefefe"
    }

    sink_event_store {
      enabled     = "true"
      endpoint    = "cn-shanghai-intranet.log.aliyuncs.com"
      project     = "wkb-wangren"
      event_store = "alert"
      role_arn    = "acs:ram::1654218965343050:role/aliyunlogetlrole"
    }

    sink_alerthub {
      enabled = "false"
    }

    no_data_severity = "6"
    tags = [
      "wkb",
      "wangren",
      "sls"
    ]
  }

  alert_name   = var.alert_name
  project_name = alicloud_log_project.defaultINsMgl.project_name
}
resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_log_project" "example" {
  name        = "terraform-example-${random_integer.default.result}"
  description = "terraform-example"
}

resource "alicloud_log_store" "example" {
  project               = alicloud_log_project.example.name
  name                  = "example-store"
  retention_period      = 3650
  shard_count           = 3
  auto_split            = true
  max_split_shard_count = 60
  append_meta           = true
}

resource "alicloud_log_alert" "example-3" {
  version           = "2.0"
  type              = "tpl"
  project_name      = alicloud_log_project.example.name
  alert_name        = "example-alert"
  alert_displayname = "example-alert"
  mute_until        = "1632486684"
  schedule {
    type            = "FixedRate"
    interval        = "5m"
    hour            = 0
    day_of_week     = 0
    delay           = 0
    run_immediately = false
  }
  template_configuration {
    id          = "sls.app.sls_ack.node.down"
    type        = "sys"
    lang        = "cn"
    annotations = {}
    tokens = {
      "interval_minute"        = "5"
      "default.action_policy"  = "sls.app.ack.builtin"
      "default.severity"       = "6"
      "sendResolved"           = "false"
      "default.project"        = "${alicloud_log_project.example.name}"
      "default.logstore"       = "k8s-event"
      "default.repeatInterval" = "4h"
      "trigger_threshold"      = "1"
      "default.clusterId"      = "example-cluster-id"
    }
  }
}
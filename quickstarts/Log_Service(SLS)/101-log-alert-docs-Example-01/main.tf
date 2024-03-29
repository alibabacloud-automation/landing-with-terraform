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

resource "alicloud_log_alert" "example" {
  project_name      = alicloud_log_project.example.name
  alert_name        = "example-alert"
  alert_displayname = "example-alert"
  condition         = "count> 100"
  dashboard         = "example-dashboard"
  schedule {
    type            = "FixedRate"
    interval        = "5m"
    hour            = 0
    day_of_week     = 0
    delay           = 0
    run_immediately = false
  }
  query_list {
    logstore    = alicloud_log_store.example.name
    chart_title = "chart_title"
    start       = "-60s"
    end         = "20s"
    query       = "* AND aliyun"
  }
  notification_list {
    type        = "SMS"
    mobile_list = ["12345678", "87654321"]
    content     = "alert content"
  }
  notification_list {
    type       = "Email"
    email_list = ["aliyun@alibaba-inc.com", "tf-example@123.com"]
    content    = "alert content"
  }
  notification_list {
    type        = "DingTalk"
    service_uri = "www.aliyun.com"
    content     = "alert content"
  }
}
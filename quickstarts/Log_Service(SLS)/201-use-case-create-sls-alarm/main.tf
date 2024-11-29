variable "region" {
  default = "cn-hangzhou"
}

variable "email_list" {
  type        = list(string)
  description = "告警发出后的通知对象"
  default     = ["ali***@alibaba-inc.com", "tf-example@123.com"]
}

provider "alicloud" {
  region = var.region
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

# 项目（Project）
resource "alicloud_log_project" "example" {
  project_name = "project-name-${random_integer.default.result}"
  description  = "tf actiontrail example"
}

# 日志库（Logstore）
resource "alicloud_log_store" "example" {
  project_name     = alicloud_log_project.example.project_name
  logstore_name    = "logstore_example_${random_integer.default.result}"
  retention_period = 3
}

# 告警规则
resource "alicloud_log_alert" "example" {
  project_name      = alicloud_log_project.example.name
  alert_name        = "alert_name_${random_integer.default.result}"
  alert_displayname = "alert_displayname_${random_integer.default.result}"
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
    type       = "Email"
    email_list = var.email_list
    content    = "alert content"
  }
}
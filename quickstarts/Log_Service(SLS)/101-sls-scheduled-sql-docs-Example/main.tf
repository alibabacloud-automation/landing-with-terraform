variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_log_project" "defaultKIe4KV" {
  description  = "${var.name}-${random_integer.default.result}"
  project_name = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_log_store" "default1LI9we" {
  hot_ttl          = "8"
  retention_period = "30"
  shard_count      = "2"
  project_name     = alicloud_log_project.defaultKIe4KV.project_name
  logstore_name    = "${var.name}-${random_integer.default.result}"
}


resource "alicloud_sls_scheduled_sql" "default" {
  description = "example-tf-scheduled-sql-0006"
  schedule {
    type            = "Cron"
    time_zone       = "+0700"
    delay           = "20"
    cron_expression = "0 0/1 * * *"
  }
  display_name = "example-tf-scheduled-sql-0006"
  scheduled_sql_configuration {
    script                  = "* | select * from log"
    sql_type                = "searchQuery"
    dest_endpoint           = "ap-northeast-1.log.aliyuncs.com"
    dest_project            = "job-e2e-project-jj78kur-ap-southeast-1"
    source_logstore         = alicloud_log_store.default1LI9we.logstore_name
    dest_logstore           = "example-open-api02"
    role_arn                = "acs:ram::1395894005868720:role/aliyunlogetlrole"
    dest_role_arn           = "acs:ram::1395894005868720:role/aliyunlogetlrole"
    from_time_expr          = "@m-1m"
    to_time_expr            = "@m"
    max_run_time_in_seconds = "1800"
    resource_pool           = "enhanced"
    max_retries             = "5"
    from_time               = "1713196800"
    to_time                 = "0"
    data_format             = "log2log"
  }
  scheduled_sql_name = var.name
  project            = alicloud_log_project.defaultKIe4KV.project_name
}
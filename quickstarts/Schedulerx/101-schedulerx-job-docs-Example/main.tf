variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_schedulerx_namespace" "CreateNameSpace" {
  namespace_name = var.name
  description    = var.name
}

resource "alicloud_schedulerx_app_group" "default" {
  max_jobs              = "100"
  monitor_contacts_json = jsonencode([{ "userName" : "name1", "userPhone" : "89756******" }, { "userName" : "name2", "ding" : "http://www.example.com" }])
  delete_jobs           = "false"
  app_type              = "1"
  namespace_source      = "schedulerx"
  group_id              = "example-appgroup-pop-autoexample"
  namespace_name        = "default"
  description           = var.name
  monitor_config_json   = jsonencode({ "sendChannel" : "sms,ding" })
  app_version           = "1"
  app_name              = "example-appgroup-pop-autoexample"
  namespace             = alicloud_schedulerx_namespace.CreateNameSpace.namespace_uid
  enable_log            = "false"
  schedule_busy_workers = "false"
}

resource "alicloud_schedulerx_job" "default" {
  timezone        = "GTM+7"
  status          = "Enable"
  max_attempt     = "0"
  description     = var.name
  parameters      = "hello word"
  job_name        = var.name
  max_concurrency = "1"
  time_config {
    data_offset     = "1"
    time_expression = "100000"
    time_type       = "3"
    calendar        = "workday"
  }
  map_task_xattrs {
    task_max_attempt      = "1"
    task_attempt_interval = "1"
    consumer_size         = "5"
    queue_size            = "10000"
    dispatcher_size       = "5"
    page_size             = "100"
  }
  namespace = alicloud_schedulerx_namespace.CreateNameSpace.namespace_uid
  group_id  = alicloud_schedulerx_app_group.default.group_id
  job_type  = "java"
  job_monitor_info {
    contact_info {
      user_phone = "12345678910"
      user_name  = "tangtao-1"
      ding       = "https://alidocs.dingtalk.com"
      user_mail  = "12345678@xx.com"
    }
    contact_info {
      user_phone = "12345678910"
      user_name  = "tangtao-2"
      ding       = "https://alidocs.dingtalk.com1"
      user_mail  = "123456789@xx.com"
    }
    monitor_config {
      timeout             = "7200"
      send_channel        = "sms"
      timeout_kill_enable = true
      timeout_enable      = true
      fail_enable         = true
      miss_worker_enable  = true
    }
  }
  class_name       = "com.aliyun.schedulerx.example.processor.SimpleJob"
  namespace_source = "schedulerx"
  attempt_interval = "30"
  fail_times       = "1"
  execute_mode     = "batch"
}
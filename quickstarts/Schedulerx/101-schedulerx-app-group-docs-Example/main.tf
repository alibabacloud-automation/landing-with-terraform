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
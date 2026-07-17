variable "name" {
  default = "tf-example"
}

data "alicloud_db_instances" "default" {
  status = "Running"
}

resource "alicloud_das_sql_log_config" "default" {
  instance_id    = data.alicloud_db_instances.default.instances.0.id
  enable         = true
  request_enable = true
  retention      = 30
  hot_retention  = 7
}
resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_log_project" "example" {
  name        = "terraform-example-${random_integer.default.result}"
  description = "terraform-example"
  tags = {
    Created = "TF",
    For     = "example",
  }
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

resource "alicloud_log_oss_export" "example" {
  project_name      = alicloud_log_project.example.name
  logstore_name     = alicloud_log_store.example.name
  export_name       = "terraform-example"
  display_name      = "terraform-example"
  bucket            = "example-bucket"
  prefix            = "root"
  suffix            = ""
  buffer_interval   = 300
  buffer_size       = 250
  compress_type     = "none"
  path_format       = "%Y/%m/%d/%H/%M"
  content_type      = "json"
  json_enable_tag   = true
  role_arn          = "role_arn_for_oss_write"
  log_read_role_arn = "role_arn_for_sls_read"
  time_zone         = "+0800"
}
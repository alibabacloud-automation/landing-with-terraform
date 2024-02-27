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
  auto_split            = true
  max_split_shard_count = 60
  append_meta           = true
}

resource "alicloud_log_oss_shipper" "example" {
  project_name    = alicloud_log_project.example.name
  logstore_name   = alicloud_log_store.example.name
  shipper_name    = "terraform-example"
  oss_bucket      = "example_bucket"
  oss_prefix      = "root"
  buffer_interval = 300
  buffer_size     = 250
  compress_type   = "none"
  path_format     = "%Y/%m/%d/%H/%M"
  format          = "json"
  json_enable_tag = true
}
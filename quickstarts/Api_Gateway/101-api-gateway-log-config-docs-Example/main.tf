variable "name" {
  default = "terraform-example"
}

resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_log_project" "example" {
  project_name = "${var.name}-${random_integer.default.result}"
  description  = var.name
}

resource "alicloud_log_store" "example" {
  project_name          = alicloud_log_project.example.project_name
  logstore_name         = "${var.name}-${random_integer.default.result}"
  shard_count           = 3
  auto_split            = true
  max_split_shard_count = 60
  append_meta           = true
}

resource "alicloud_api_gateway_log_config" "example" {
  sls_project   = alicloud_log_project.example.project_name
  sls_log_store = alicloud_log_store.example.logstore_name
  log_type      = "PROVIDER"
}
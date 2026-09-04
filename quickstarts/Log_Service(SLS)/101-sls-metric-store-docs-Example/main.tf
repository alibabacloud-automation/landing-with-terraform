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

resource "alicloud_log_project" "default" {
  project_name = "${var.name}-${random_integer.default.result}"
  description  = "terraform example project for metric store"
}

resource "alicloud_sls_metric_store" "default" {
  project_name          = alicloud_log_project.default.project_name
  metric_store_name     = "${var.name}-metric-store"
  ttl                   = 30
  shard_count           = 2
  auto_split            = true
  max_split_shard_count = 64
  append_meta           = false
}
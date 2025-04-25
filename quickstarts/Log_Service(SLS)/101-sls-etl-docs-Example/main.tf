variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_log_project" "defaulthhAPo6" {
  description  = "terraform-etl-example-813"
  project_name = "terraform-etl-example-330"
}

resource "alicloud_log_store" "defaultzWKLkp" {
  hot_ttl          = "8"
  retention_period = "30"
  shard_count      = "2"
  project_name     = alicloud_log_project.defaulthhAPo6.id
  logstore_name    = "example"
}

resource "alicloud_sls_etl" "default" {
  project     = alicloud_log_project.defaulthhAPo6.id
  description = "etl-1740472705-185721"
  configuration {
    script   = "* | extend a=1"
    lang     = "SPL"
    role_arn = var.name
    sink {
      name     = "11111"
      endpoint = "cn-hangzhou-intranet.log.aliyuncs.com"
      project  = "gy-hangzhou-huolang-1"
      logstore = "gy-rm2"
      datasets = ["__UNNAMED__"]
      role_arn = var.name
    }
    logstore  = alicloud_log_store.defaultzWKLkp.logstore_name
    from_time = "1706771697"
    to_time   = "1738394097"
  }
  job_name     = "etl-1740472705-185721"
  display_name = "etl-1740472705-185721"
}
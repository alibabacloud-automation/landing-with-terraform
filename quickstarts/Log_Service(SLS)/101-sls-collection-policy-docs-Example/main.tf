variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-shanghai"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_log_project" "project_create_01" {
  description  = var.name
  project_name = format("%s1%s", var.name, random_integer.default.result)
}

resource "alicloud_log_store" "logstore_create_01" {
  retention_period = "30"
  shard_count      = "2"
  project_name     = alicloud_log_project.project_create_01.project_name
  logstore_name    = format("%s1%s", var.name, random_integer.default.result)
}

resource "alicloud_log_project" "update_01" {
  description  = var.name
  project_name = format("%s2%s", var.name, random_integer.default.result)
}

resource "alicloud_log_store" "logstore002" {
  retention_period = "30"
  shard_count      = "2"
  project_name     = alicloud_log_project.update_01.project_name
  logstore_name    = format("%s2%s", var.name, random_integer.default.result)
}


resource "alicloud_sls_collection_policy" "default" {
  policy_config {
    resource_mode = "all"
    regions       = ["cn-hangzhou"]
  }
  data_code          = "metering_log"
  centralize_enabled = true
  product_code       = "oss"
  policy_name        = "xc-example-oss-01"
  enabled            = true
  data_config {
    data_region = "cn-hangzhou"
  }
  centralize_config {
    dest_ttl      = "3"
    dest_region   = "cn-shanghai"
    dest_project  = alicloud_log_project.project_create_01.project_name
    dest_logstore = alicloud_log_store.logstore_create_01.logstore_name
  }
  resource_directory {
    account_group_type = "custom"
    members            = ["1936728897040477"]
  }
}
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

resource "alicloud_log_project" "defaulteyHJsO" {
  description  = "terraform-oss-example-910"
  project_name = format("%s1%s", var.name, random_integer.default.result)
}

resource "alicloud_log_store" "defaultxeHfXC" {
  hot_ttl          = "8"
  retention_period = "30"
  shard_count      = "2"
  project_name     = alicloud_log_project.defaulteyHJsO.project_name
  logstore_name    = format("%s1%s", var.name, random_integer.default.result)
}

resource "alicloud_oss_bucket" "defaultiwj0xO" {
  bucket        = format("%s1%s", var.name, random_integer.default.result)
  storage_class = "Standard"
}


resource "alicloud_sls_oss_export_sink" "default" {
  project = alicloud_log_project.defaulteyHJsO.project_name
  configuration {
    logstore = alicloud_log_store.defaultxeHfXC.logstore_name
    role_arn = "acs:ram::12345678901234567:role/aliyunlogdefaultrole"
    sink {
      bucket           = alicloud_oss_bucket.defaultiwj0xO.bucket
      role_arn         = "acs:ram::12345678901234567:role/aliyunlogdefaultrole"
      time_zone        = "+0700"
      content_type     = "json"
      compression_type = "none"
      content_detail   = jsonencode({ "enableTag" : false })
      buffer_interval  = "300"
      buffer_size      = "256"
      endpoint         = "https://oss-cn-shanghai-internal.aliyuncs.com"
    }
    from_time = "1732165733"
    to_time   = "1732166733"
  }
  job_name     = "export-oss-1731404933-00001"
  display_name = "exampleterraform"
}
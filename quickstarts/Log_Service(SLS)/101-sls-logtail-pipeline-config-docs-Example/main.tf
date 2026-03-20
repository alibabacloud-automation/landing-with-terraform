provider "alicloud" {
  region = "cn-shanghai"
}

resource "random_integer" "default" {
  max = 99999
  min = 10000
}

variable "name" {
  default = "terraform-example"
}

resource "alicloud_log_project" "example" {
  project_name = "${var.name}-${random_integer.default.result}"
  description  = "terraform logtail pipeline config example"
}

resource "alicloud_log_store" "example" {
  project_name          = alicloud_log_project.example.project_name
  logstore_name         = "example-store"
  shard_count           = 2
  auto_split            = true
  max_split_shard_count = 64
}

resource "alicloud_sls_logtail_pipeline_config" "example" {
  project     = alicloud_log_project.example.project_name
  config_name = "${var.name}-${random_integer.default.result}"

  inputs = [{
    Type                     = "input_file"
    FilePaths                = "[\\\"/home/*.log\\\"]"
    EnableContainerDiscovery = false
    MaxDirSearchDepth        = 0
    FileEncoding             = "utf8"
  }]

  processors = [{
    Type      = "processor_parse_regex_native"
    SourceKey = "content"
    Regex     = ".*"
    Keys      = "[\\\"key1\\\",\\\"key2\\\"]"
  }]

  flushers = [{
    Type          = "flusher_sls"
    Logstore      = alicloud_log_store.example.logstore_name
    TelemetryType = "logs"
    Region        = "cn-shanghai"
    Endpoint      = "cn-shanghai-intranet.log.aliyuncs.com"
  }]

  aggregators = [{
    Type           = "aggregator_default"
    MaxSizeBytes   = 1048576
    MaxTimeSeconds = 3
  }]
}
variable "region" {
  default = "cn-hangzhou"
}

variable "identify_list" {
  type        = list(string)
  description = "机器组包含的机器IP"
  default     = ["10.0.0.1", "10.0.0.2"]
}

provider "alicloud" {
  region = var.region
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

# 项目（Project）
resource "alicloud_log_project" "example" {
  project_name = "project-name-${random_integer.default.result}"
  description  = "tf actiontrail example"
}

# 机器组
resource "alicloud_log_machine_group" "example" {
  project       = alicloud_log_project.example.project_name
  name          = "terraform-example-${random_integer.default.result}"
  identify_type = "ip"
  topic         = "terraform"
  identify_list = var.identify_list
}

# 日志库（Logstore）
resource "alicloud_log_store" "example" {
  project_name     = alicloud_log_project.example.project_name
  logstore_name    = "logstore_example_${random_integer.default.result}"
  retention_period = 3
}

# Logtail采集
resource "alicloud_logtail_config" "example" {
  project     = alicloud_log_project.example.project_name
  logstore    = alicloud_log_store.example.logstore_name
  name        = "config-sample-${random_integer.default.result}"
  input_type  = "file"
  output_type = "LogService"
  input_detail = jsonencode(
    {
      "logPath" : "/logPath",
      "filePattern" : "access.log",
      "logType" : "json_log",
      "topicFormat" : "default",
      "discardUnmatch" : false,
      "enableRawLog" : true,
      "fileEncoding" : "gbk",
      "maxDepth" : 10
    }
  )
}

# 应用Logtail采集配置到机器组
resource "alicloud_logtail_attachment" "example" {
  project             = alicloud_log_project.example.project_name
  logtail_config_name = alicloud_logtail_config.example.name
  machine_group_name  = alicloud_log_machine_group.example.name
}
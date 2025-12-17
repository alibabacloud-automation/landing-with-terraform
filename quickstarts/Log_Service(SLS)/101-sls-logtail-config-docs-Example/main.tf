resource "random_integer" "default" {
  max = 99999
  min = 10000
}

variable "name" {
  default = "tfaccsls62147"
}

variable "project_name" {
  default = "project-for-logtail-terraform"
}

resource "alicloud_log_project" "defaultuA28zS" {
  project_name = var.project_name
}

resource "alicloud_sls_logtail_config" "default" {
  project_name = alicloud_log_project.defaultuA28zS.project_name
  output_detail {
    endpoint      = "cn-hangzhou-intranet.log.aliyuncs.com"
    region        = "cn-hangzhou"
    logstore_name = "example"
  }

  output_type = "LogService"
  input_detail = jsonencode({
    "adjustTimezone" : false,
    "delayAlarmBytes" : 0,
    "delaySkipBytes" : 0,
    "discardNonUtf8" : false,
    "discardUnmatch" : true,
    "dockerFile" : false,
    "enableRawLog" : false,
    "enableTag" : false,
    "fileEncoding" : "utf8",
    "filePattern" : "access*.log",
    "filterKey" : ["key1"],
    "filterRegex" : ["regex1"],
    "key" : ["key1", "key2"],
    "localStorage" : true,
    "logBeginRegex" : ".*",
    "logPath" : "/var/log/httpd",
    "logTimezone" : "",
    "logType" : "common_reg_log",
    "maxDepth" : 1000,
    "maxSendRate" : -1,
    "mergeType" : "topic",
    "preserve" : true,
    "preserveDepth" : 0,
    "priority" : 0,
    "regex" : "(w+)(s+)",
    "sendRateExpire" : 0,
    "sensitive_keys" : [],
    "tailExisted" : false,
    "timeFormat" : "%Y/%m/%d %H:%M:%S",
    "timeKey" : "time",
    "topicFormat" : "none"
  })
  logtail_config_name = "tfaccsls62147"
  input_type          = "file"
}
provider "alicloud" {
  region = "cn-hangzhou"
}

resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_log_project" "default" {
  project_name = "example-value-${random_integer.default.result}"
}

resource "alicloud_log_store" "default" {
  project_name  = alicloud_log_project.default.name
  logstore_name = "example-value"
}

# add index for logstore, which is used to query logs
locals {
  sls_default_token = ", '\";=()[]{}?@&<>/:\n\t\r"
}

resource "alicloud_log_store_index" "example" {
  project  = alicloud_log_project.default.name
  logstore = alicloud_log_store.default.name
  full_text {
    case_sensitive = false
    token          = local.sls_default_token
  }
  field_search {
    name             = "aggPeriodSeconds"
    enable_analytics = true
    type             = "long"
    token            = local.sls_default_token
  }
  field_search {
    name             = "concurrentRequests"
    enable_analytics = true
    type             = "long"
    token            = local.sls_default_token
  }
  field_search {
    name             = "cpuPercent"
    enable_analytics = true
    type             = "double"
    token            = local.sls_default_token
  }
  field_search {
    name             = "cpuQuotaPercent"
    enable_analytics = true
    type             = "double"
    token            = local.sls_default_token
  }
  field_search {
    name             = "functionName"
    enable_analytics = true
    type             = "text"
    token            = local.sls_default_token
    case_sensitive   = true
  }
  field_search {
    name             = "hostname"
    enable_analytics = true
    type             = "text"
    token            = local.sls_default_token
  }
  field_search {
    name             = "instanceID"
    enable_analytics = true
    type             = "text"
    token            = local.sls_default_token
  }
  field_search {
    name             = "ipAddress"
    enable_analytics = true
    type             = "text"
    token            = local.sls_default_token
  }
  field_search {
    name             = "memoryLimitMB"
    enable_analytics = true
    type             = "double"
    token            = local.sls_default_token
  }
  field_search {
    name             = "memoryUsageMB"
    enable_analytics = true
    type             = "double"
    token            = local.sls_default_token
  }
  field_search {
    name             = "memoryUsagePercent"
    enable_analytics = true
    type             = "double"
    token            = local.sls_default_token
  }
  field_search {
    name             = "operation"
    enable_analytics = true
    type             = "text"
    token            = local.sls_default_token
  }
  field_search {
    name             = "qualifier"
    enable_analytics = true
    type             = "text"
    token            = local.sls_default_token
    case_sensitive   = true
  }
  field_search {
    name             = "rxBytes"
    enable_analytics = true
    type             = "long"
    token            = local.sls_default_token
  }
  field_search {
    name             = "rxTotalBytes"
    enable_analytics = true
    type             = "long"
    token            = local.sls_default_token
  }
  field_search {
    name             = "serviceName"
    enable_analytics = true
    type             = "text"
    token            = local.sls_default_token
    case_sensitive   = true
  }
  field_search {
    name             = "txBytes"
    enable_analytics = true
    type             = "long"
    token            = local.sls_default_token
  }
  field_search {
    name             = "txTotalBytes"
    enable_analytics = true
    type             = "long"
    token            = local.sls_default_token
  }
  field_search {
    name             = "versionId"
    enable_analytics = true
    type             = "text"
    token            = local.sls_default_token
  }
  field_search {
    name             = "events"
    enable_analytics = true
    type             = "json"
    token            = local.sls_default_token
  }
  field_search {
    name             = "isColdStart"
    enable_analytics = true
    type             = "text"
    token            = local.sls_default_token
  }
  field_search {
    name             = "hasFunctionError"
    enable_analytics = true
    type             = "text"
    token            = local.sls_default_token
  }
  field_search {
    name             = "errorType"
    enable_analytics = true
    type             = "text"
    token            = local.sls_default_token
  }
  field_search {
    name             = "triggerType"
    enable_analytics = true
    type             = "text"
    token            = local.sls_default_token
  }
  field_search {
    name             = "durationMs"
    enable_analytics = true
    type             = "double"
    token            = local.sls_default_token
  }
  field_search {
    name             = "statusCode"
    enable_analytics = true
    type             = "long"
    token            = local.sls_default_token
  }
}

resource "alicloud_ram_role" "default" {
  name        = "fcservicerole-${random_integer.default.result}"
  document    = <<EOF
  {
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Effect": "Allow",
          "Principal": {
            "Service": [
              "fc.aliyuncs.com"
            ]
          }
        }
      ],
      "Version": "1"
  }
  EOF
  description = "this is a example"
  force       = true
}

resource "alicloud_ram_role_policy_attachment" "default" {
  role_name   = alicloud_ram_role.default.name
  policy_name = "AliyunLogFullAccess"
  policy_type = "System"
}

resource "alicloud_fc_service" "default" {
  name        = "example-value-${random_integer.default.result}"
  description = "example-value"
  role        = alicloud_ram_role.default.arn
  log_config {
    project                 = alicloud_log_project.default.name
    logstore                = alicloud_log_store.default.name
    enable_instance_metrics = true
    enable_request_metrics  = true
  }
  tags = {
    "ExampleKey" = "example-value"
  }
}
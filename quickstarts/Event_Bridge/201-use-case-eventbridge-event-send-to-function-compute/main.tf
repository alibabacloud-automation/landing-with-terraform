# 定义变量
variable "region_id" {
  type    = string
  default = "cn-shenzhen"
}

# 配置阿里云Provider
provider "alicloud" {
  region = var.region_id
}

# 获取当前账号信息
data "alicloud_caller_identity" "current" {}

# 创建自定义事件总线
resource "alicloud_event_bridge_event_bus" "demo_event_bus" {
  event_bus_name = "demo_event_yiyi"
  description    = "This is a demo event bus."
}

# 创建自定义事件源
resource "alicloud_event_bridge_event_source" "demo_event_source" {
  event_bus_name         = alicloud_event_bridge_event_bus.demo_event_bus.event_bus_name
  event_source_name      = "demo_event_source_yiyi"
  description            = "This is a demo event source."
  linked_external_source = false
}

# 创建函数计算服务
resource "alicloud_fc_service" "fc_service" {
  name        = "eb-fc-service"
  description = "This service handles events from EventBridge."
  publish     = true
}

# 自动生成Python脚本文件
resource "local_file" "python_script" {
  content  = <<EOF
# -*- coding: utf-8 -*-
import logging

def handler(event, context):
    logger = logging.getLogger()
    logger.info('Event: ' + str(event))
    return str(event)
EOF
  filename = "${path.module}/src/index.py"
}

# 将Python脚本文件打包成ZIP
data "archive_file" "code" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/code.zip"
  depends_on  = [local_file.python_script]
}

# 创建OSS Bucket
resource "alicloud_oss_bucket" "code_bucket" {
  bucket = "fc-code-bucket-${random_string.random_suffix.result}"
}

# 生成随机字符串后缀确保OSS Bucket名称的唯一性
resource "random_string" "random_suffix" {
  length  = 8
  special = false
  upper   = false
}

# 将ZIP包上传到OSS
resource "alicloud_oss_bucket_object" "function_code" {
  bucket = alicloud_oss_bucket.code_bucket.bucket
  key    = "index.py.zip"
  source = data.archive_file.code.output_path
}

# 创建函数计算函数，使用OSS中的代码
resource "alicloud_fc_function" "fc_function" {
  service     = alicloud_fc_service.fc_service.name
  name        = "eb-fc-function"
  description = "This function executes based on EventBridge rules."
  oss_bucket  = alicloud_oss_bucket.code_bucket.bucket
  oss_key     = alicloud_oss_bucket_object.function_code.key
  memory_size = 128
  runtime     = "python3"
  handler     = "index.handler"
}

# 创建事件桥规则
resource "alicloud_event_bridge_rule" "demo_rule" {
  event_bus_name = alicloud_event_bridge_event_bus.demo_event_bus.event_bus_name
  rule_name      = "demo_rule"
  description    = "Rule for triggering Function Compute on events."
  filter_pattern = jsonencode({
    "source" : [alicloud_event_bridge_event_source.demo_event_source.id]
  })
  lifecycle {
    ignore_changes = [
      targets
    ]
  }
  targets {
    target_id = "demo-fc-target"
    type      = "acs.fc.function"
    endpoint  = "acs:fc:${var.region_id}:${data.alicloud_caller_identity.current.account_id}:services/${alicloud_fc_service.fc_service.name}.LATEST/functions/${alicloud_fc_function.fc_function.name}"

    param_list {
      resource_key = "serviceName"
      form         = "CONSTANT"
      value        = alicloud_fc_service.fc_service.name
    }
    param_list {
      resource_key = "functionName"
      form         = "CONSTANT"
      value        = alicloud_fc_function.fc_function.name
    }
    param_list {
      resource_key = "Qualifier"
      form         = "CONSTANT"
      value        = "LATEST"
    }
    param_list {
      resource_key = "Body"
      form         = "ORIGINAL"
    }
  }
}
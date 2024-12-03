# 定义变量
variable "region_id" {
  type    = string
  default = "cn-shenzhen"
}

variable "dingtalk_webhook_endpoint" {
  type    = string
  default = "https://oapi.dingtalk.com/robot/send?access_token=8e7d6880d9eca81764ee888bdfb03fd795******************"
}

variable "dingtalk_secret_key" {
  type    = string
  default = "SECedd9fbd3eb89aa1986******************"
}

# 配置阿里云Provider
provider "alicloud" {
  region = var.region_id
}

resource "alicloud_event_bridge_rule" "audit_notify" {
  event_bus_name = "default"
  rule_name      = "audit_notify_fofo"
  description    = "yiyi"

  filter_pattern = jsonencode(
    {
      "type" : [
        {
          "suffix" : ":ActionTrail:ApiCall"
        }
      ]
    }
  )

  targets {
    target_id = "test-target"
    endpoint  = var.dingtalk_webhook_endpoint
    type      = "acs.dingtalk"

    param_list {
      resource_key = "URL"
      form         = "CONSTANT"
      value        = var.dingtalk_webhook_endpoint
    }

    param_list {
      resource_key = "SecretKey"
      form         = "CONSTANT"
      value        = var.dingtalk_secret_key
    }

    param_list {
      resource_key = "Body"
      form         = "TEMPLATE"
      value = jsonencode(
        {
          "source" : "$.source",
          "type" : "$.type",
          "region" : "$.data.acsRegion",
          "accountId" : "$.data.userIdentity.accountId",
          "eventName" : "$.data.eventName",
        }
      )
      template = jsonencode(
        {
          "msgtype" : "text",
          "text" : {
            "content" : "测试：来自 $${source} 的 $${type} 审计事件：$${accountId} 在 $${region} 执行了 $${eventName} 操作"
          }
        }
      )
    }
  }
}
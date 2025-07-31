variable "region" {
  type        = string
  default     = "cn-hangzhou"
  description = "地域，例如：cn-hangzhou。所有地域及可用区请参见文档：https://help.aliyun.com/document_detail/40654.html#09f1dc16b0uke"
}

variable "ZoneId" {
  type        = string
  default     = "cn-hangzhou-f"
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Instance::ZoneId",
    "Description": {
      "zh-cn": "可用区",
      "en": "Availability Zone"
    },
    "Label": {
      "zh-cn": "可用区",
      "en": "Availability Zone"
    }
  }
  EOT
}

variable "InstanceType" {
  type        = string
  default     = "ecs.e-c1m1.large"
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",
    "AssociationPropertyMetadata": {
      "ZoneId": "$${ZoneId}",
      "InstanceChargeType": "PostPaid",
      "SystemDiskCategory": "cloud_essd",
      "Constraints": {
        "Architecture": ["X86"],
        "vCPU": [2],
        "Memory": [2]
      }
    },
    "Label": {
      "zh-cn": "实例类型",
      "en": "Instance Type"
    }
  }
  EOT
}

variable "ecs_instance_password" {
  type        = string
  sensitive   = true
  description = "服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
}

variable "bai_lian_api_key" {
  type        = string
  description = "百炼 API-KEY，需开通百炼模型服务再获取 API-KEY，详情请参考：https://help.aliyun.com/zh/model-studio/developer-reference/get-api-key"
}

variable "CommonName" {
  type    = string
  default = "deepseek-private-ai"
}

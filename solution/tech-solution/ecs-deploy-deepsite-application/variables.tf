variable "zone_id" {
  type        = string
  default     = "cn-shanghai-b"
  description = <<EOT
  {
    "Label": {
      "en": "Availability Zone",
      "zh-cn": "可用区"
    },
    "AssociationProperty": "ALIYUN::ECS::Instance::ZoneId",
    "AssociationPropertyMetadata": {
      "RegionId": "cn-shanghai",
      "AutoSelectFirst": true
    }
  }
  EOT
}

variable "instance_type" {
  type        = string
  default     = "ecs.e-c1m2.large"
  description = <<EOT
  {
    "Label": {
      "en": "Instance Type",
      "zh-cn": "实例类型"
    },
    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",
    "AssociationPropertyMetadata": {
      "ZoneId": "$${zone_id}",
      "InstanceChargeType": "PostPaid",
      "SystemDiskCategory": "cloud_essd_entry",
      "Constraints": {
        "Architecture": ["X86"],
        "vCPU": [2],
        "Memory": [4]
      }
    },
    "Description": {
      "zh-cn": "推荐规格：ecs.e-c1m2.large（2 vCPU 4 GiB）",
      "en": "Recommended: ecs.e-c1m2.large (2 vCPU 4 GiB)"
    }
  }
  EOT
}

variable "ecs_instance_password" {
  type        = string
  sensitive   = true
  description = <<EOT
  {
    "Label": {
      "en": "Instance Password",
      "zh-cn": "实例密码"
    },
    "Description": {
      "en": "Server login password, Length 8-30, must contain three(Capital letters, lowercase letters, numbers, ()\`~!@#$%^&*_-+=|{}[]:;'<>,.?/ Special symbol in)",
      "zh-cn": "服务器登录密码，长度8-30，必须包含三项（大写字母、小写字母、数字、 ()\`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
    },
    "ConstraintDescription": {
      "en": "Length 8-30, must contain three(Capital letters, lowercase letters, numbers, ()\`~!@#$%^&*_-+=|{}[]:;'<>,.?/ Special symbol in)",
      "zh-cn": "长度8-30，必须包含三项（大写字母、小写字母、数字、 ()\`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
    },
    "AssociationProperty": "ALIYUN::ECS::Instance::Password"
  }
  EOT
}


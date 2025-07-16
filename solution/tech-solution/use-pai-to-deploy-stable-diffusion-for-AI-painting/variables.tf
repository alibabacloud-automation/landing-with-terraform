variable "region" {
  type        = string
  description = "地域，由于在新加坡地域开通弹性公网 IP 服务后，访问 Civitai 和Github 的网速高效稳定，此处选择新加坡"
  default     = "ap-southeast-1"
}

variable "zone_id" {
  type        = string
  description = "可用区ID"
  default     = "ap-southeast-1c"
}

variable "instance_type" {
  type        = string
  description = "PAI-EAS实例规格"
  default     = "ecs.gn6i-c16g1.4xlarge"

  validation {
    condition     = can(regex("(^ecs.*gn.*)|(^ml.*)|(^ecs.*gu.*)", var.instance_type))
    error_message = "实例类型必须匹配模式 (^ecs.*gn.*)|(^ml.*)|(^ecs.*gu.*)"
  }
} 
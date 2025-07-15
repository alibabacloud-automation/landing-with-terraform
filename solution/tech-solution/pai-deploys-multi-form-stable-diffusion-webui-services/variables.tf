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
    condition = can(regex("(^ecs.*gn.*)|(^ml.*)|(^ecs.*gu.*)", var.instance_type))
    error_message = "实例类型必须匹配模式 (^ecs.*gn.*)|(^ml.*)|(^ecs.*gu.*)"
  }
} 
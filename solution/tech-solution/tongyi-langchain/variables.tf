variable "region" {
  type        = string
  default     = "cn-hangzhou"
  description = "地域，例如：cn-hangzhou。所有地域及可用区请参见文档：https://help.aliyun.com/document_detail/40654.html#09f1dc16b0uke"
}

variable "zone_id" {
  type        = string
  description = "可用区ID"
  default     = "cn-hangzhou-f"
}

variable "instance_type" {
  type        = string
  description = "PAI-EAS实例规格"
  default     = "ml.gu7i.c8m30.1-gu30"

  validation {
    condition = contains([
      "ml.gu7i.c8m30.1-gu30",
      "ecs.gn6e-c12g1.3xlarge",
      "ecs.gn7i-c8g1.2xlarge",
      "ecs.gn6i-c16g1.4xlarge",
      "ecs.gn7i-c16g1.4xlarge",
      "ecs.gn6i-c8g1.2xlarge",
      "ecs.gn6i-c4g1.xlarge"
    ], var.instance_type)
    error_message = "实例类型必须是以下之一：ml.gu7i.c8m30.1-gu30, ecs.gn6e-c12g1.3xlarge, ecs.gn7i-c8g1.2xlarge, ecs.gn6i-c16g1.4xlarge, ecs.gn6i-c8g1.2xlarge, ecs.gn6i-c4g1.xlarge"
  }
} 
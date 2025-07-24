variable "region" {
  type        = string
  default     = "cn-hangzhou"
  description = "地域，例如：cn-hangzhou。所有地域及可用区请参见文档：https://help.aliyun.com/document_detail/40654.html#09f1dc16b0uke"
}

variable "zone_id" {
  type        = string
  description = "可用区ID"
  default     = "cn-hangzhou-h"
}

variable "bai_lian_api_key" {
  type        = string
  description = "百炼 API-KEY，需开通百炼模型服务再获取 API-KEY，详情请参考：https://help.aliyun.com/zh/model-studio/developer-reference/get-api-key"
}

variable "bai_lian_app_id" {
  type        = string
  description = "百炼应用的应用ID"
}

variable "instance_type" {
  type        = string
  description = "ECS实例规格"
  default     = "ecs.g6.large"
}

variable "ecs_instance_password" {
  type        = string
  sensitive   = true
  description = "服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"

  validation {
    condition     = length(var.ecs_instance_password) >= 8 && length(var.ecs_instance_password) <= 30
    error_message = "密码长度必须在8-30位之间"
  }
}

variable "common_name" {
  type        = string
  description = "资源名称前缀"
  default     = "RAG"
} 
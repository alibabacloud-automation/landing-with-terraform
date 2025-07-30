variable "region" {
  description = "地域"
  type        = string
  default     = "cn-hangzhou"
}

variable "common_name" {
  type        = string
  description = "应用名称"
  default     = "high-availability"
}

variable "ecs_instance_password" {
  type        = string
  description = "服务器登录密码,长度8~30，必须包含三项（大写字母、小写字母、数字、特殊符号）"
  sensitive   = true
}
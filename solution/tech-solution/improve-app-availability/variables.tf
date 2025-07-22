variable "region" {
  description = "地域"
  type        = string
  default     = "cn-hangzhou"
}

variable "common_name" {
  description = "弹性应用名称"
  type        = string
  default     = "elastic-app"
}

variable "ecs_instance_password" {
  description = "服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/中的特殊符号）"
  type        = string
  sensitive   = true
}

variable "scale_up_time" {
  description = "自动扩容执行时间"
  type        = string
  default     = null
}

variable "scale_down_time" {
  description = "自动缩容执行时间"
  type        = string
  default     = null
}
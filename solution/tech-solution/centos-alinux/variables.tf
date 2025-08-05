variable "region" {
  description = "地域"
  type        = string
  default     = "cn-hangzhou"
}

variable "ecs_instance_password" {
  type        = string
  description = "服务器登录密码，长度8-30，必须包含三项（大写字母、小写字母、数字、特殊符号）。"
  sensitive   = true
}

variable "db_password" {
  type        = string
  description = "数据库用户密码，长度为8~32位，需包含大写字母、小写字母、特殊字符和数字。"
  sensitive   = true
}
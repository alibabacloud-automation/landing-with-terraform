variable "region" {
  description = "地域"
  type        = string
  default     = "cn-hangzhou"
}

variable "common_name" {
  description = "通用名称前缀"
  type        = string
  default     = "serverless"
}

variable "db_user_name" {
  description = "MySQL数据库账号"
  type        = string
  default     = "applets"
}

variable "db_password" {
  description = "MySQL数据库密码，长度8-30，必须包含三项（大写字母、小写字母、数字、特殊符号）"
  type        = string
  sensitive   = true
}

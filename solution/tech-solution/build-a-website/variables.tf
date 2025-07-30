variable "region" {
  description = "地域"
  type        = string
  default     = "cn-hangzhou"
}

variable "app_name" {
  type        = string
  description = "APP名称"
  default     = "mobi_app"
}

variable "db_user_name" {
  type        = string
  description = "数据库用户名"
  default     = "db_user"
}

variable "db_password" {
  type        = string
  description = "数据库密码"
  sensitive   = true
}

variable "db_name" {
  type        = string
  description = "数据库名"
  default     = "db_name"
}
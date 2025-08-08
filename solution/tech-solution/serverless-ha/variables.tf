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
  validation {
    condition     = can(regex("^[a-z][a-z0-9_]{0,31}$", var.db_user_name))
    error_message = "数据库用户名由2到32个小写字母组成，支持小写字母、数字和下划线，以小写字母开头。"
  }
}

variable "db_password" {
  description = "MySQL数据库密码，长度8-30，必须包含三项（大写字母、小写字母、数字、特殊符号）"
  type        = string
  sensitive   = true
  validation {
    condition = var.db_password == null || (
      length(var.db_password) >= 8 && length(var.db_password) <= 30 &&
      can(regex("[a-z]", var.db_password)) &&
      can(regex("[A-Z]", var.db_password)) &&
      can(regex("[0-9]", var.db_password)) &&
      can(regex("[!@#$%^&*()_+-=]", var.db_password))
    )
    error_message = "密码长度8-30，必须包含三项（大写字母、小写字母、数字、特殊符号）。"
  }
}

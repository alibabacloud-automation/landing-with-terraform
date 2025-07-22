variable "region" {
  description = "地域"
  type = string
  default = "cn-hangzhou"
}

variable "common_name" {
  type    = string
  description = "应用名称"
  default = "high-availability"
}

variable "ecs_instance_password" {
  type      = string
  sensitive = true
  description = "服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
}

variable "db_user_name" {
  type        = string
  description = "数据库用户名，由 2 到 32 个小写字母组成，支持小写字母、数字和下划线，以小写字母开头。"
  validation {
    condition     = can(regex("^[a-z][a-z0-9_]{0,31}$", var.db_user_name))
    error_message = "由 2 到 32 个小写字母组成，支持小写字母、数字和下划线，以小写字母开头。"
  }
  default = "high_availability"
}

variable "db_password" {
  type      = string
  sensitive = true
  description = "数据库账号密码，长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
}

variable "database_name" {
  type        = string
  description = "数据名称，由 2 到 32 个小写字母组成，支持小写字母、数字和下划线，以小写字母开头。"
  validation {
    condition     = can(regex("^[a-z][a-z0-9_]{0,31}$", var.database_name))
    error_message = "由 2 到 32 个小写字母组成，支持小写字母、数字和下划线，以小写字母开头。"
  }
  default = "high_availability"
}
variable "region" {
  description = "地域"
  type        = string
  default     = "cn-hangzhou"
}

variable "common_name" {
  description = "名称"
  type        = string
  default     = "app"
}

variable "ecs_instance_password" {
  description = "服务器登录密码，长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.? 中的特殊符号）"
  type        = string
  sensitive   = true
}

variable "db_user_name" {
  type        = string
  description = "数据库用户名，由 2 到 32 个小写字母组成，支持小写字母、数字和下划线，以小写字母开头。"
  validation {
    condition     = can(regex("^[a-z][a-z0-9_]{0,31}$", var.db_user_name))
    error_message = "由 2 到 32 个小写字母组成，支持小写字母、数字和下划线，以小写字母开头。"
  }
  default = "app"
}

variable "db_password" {
  description = "数据库账号密码，长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
  type        = string
  sensitive   = true
}

variable "database_name" {
  type        = string
  description = "数据名称，由 2 到 32 个小写字母组成，支持小写字母、数字和下划线，以小写字母开头。"
  validation {
    condition     = can(regex("^[a-z][a-z0-9_]{0,31}$", var.database_name))
    error_message = "由 2 到 32 个小写字母组成，支持小写字母、数字和下划线，以小写字母开头。"
  }
  default = "app"
}

variable "domain_name" {
  description = "域名"
  type = object({
    domain_prefix = string
    domain_name   = string
  })
  default = null
}
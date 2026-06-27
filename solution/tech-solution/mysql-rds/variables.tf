variable "region" {
  description = "地域"
  type        = string
  default     = "cn-hangzhou"
}


variable "db_instance_engine_and_version" {
  type        = string
  description = "引擎类型及版本，数据库引擎类型及版本，默认为MySQL 8.0。"
  validation {
    condition     = contains(["MySQL 8.0"], var.db_instance_engine_and_version)
    error_message = "数据库引擎类型及版本必须为MySQL 8.0。"
  }
  default = "MySQL 8.0"
}

variable "db_password" {
  type        = string
  description = "RDS数据库密码，长度8-30，必须包含三项（大写字母、小写字母、数字、特殊符号）。"
  sensitive   = true
  validation {
    condition     = length(var.db_password) >= 8 && length(var.db_password) <= 30
    error_message = "密码长度必须在8-30之间。"
  }
}

variable "db_user_name" {
  type        = string
  description = "RDS数据库账号，由2到16个小写字母组成，下划线。必须以字母开头，以字母数字字符结尾。"
  validation {
    condition     = can(regex("^[a-z][a-z0-9_]{0,14}[a-z0-9]$", var.db_user_name)) && length(var.db_user_name) >= 2 && length(var.db_user_name) <= 16
    error_message = "由2到16个小写字母组成，下划线。必须以字母开头，以字母数字字符结尾。"
  }
  default = "dbuser"
}

variable "ecs_instance_password" {
  type        = string
  description = "实例密码，服务器登录密码，长度8-30，必须包含三项（大写字母、小写字母、数字、特殊符号）。"
  sensitive   = true
  validation {
    condition     = length(var.ecs_instance_password) >= 8 && length(var.ecs_instance_password) <= 30
    error_message = "密码长度必须在8-30之间。"
  }
}

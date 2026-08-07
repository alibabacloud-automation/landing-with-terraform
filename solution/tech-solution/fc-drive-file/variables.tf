variable "region" {
  description = "地域"
  type        = string
  default     = "cn-hangzhou"
}

variable "demo_user_name" {
  type        = string
  description = "demo_user_name，在浏览器中登录示例应用程序时的用户名。3 到 63 个字母组成。"
  validation {
    condition     = can(regex("^[a-zA-Z-]{3,63}$", var.demo_user_name))
    error_message = "3 到 63 个字母组成。"
  }
  default = "demo-user-example"
}

variable "demo_user_password" {
  type        = string
  description = "demo_user_password，在浏览器中登录示例应用程序时的密码，长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
  sensitive   = true
  default     = "Demo_user_password!"
}

variable "bucket_name" {
  type        = string
  description = "bucket_name，存储空间名称。长度为3~63个字符，必须以小写字母或数字开头和结尾，可以包含小写字母、数字和连字符(-)；需要全网唯一性，已经存在的不能在创建。"
  default     = "file-processing-example"
}


variable "ecs_instance_password" {
  type        = string
  description = "ecs_instance_password，服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
  sensitive   = true
}

variable "db_user_name" {
  type        = string
  description = "db_user_name，RDS数据库账号。由 2 到 32 个小写字母组成，支持小写字母、数字和下划线，以小写字母开头。"
  validation {
    condition     = can(regex("^[a-z][a-z0-9_]{0,31}$", var.db_user_name))
    error_message = "由 2 到 32 个小写字母组成，支持小写字母、数字和下划线，以小写字母开头。"
  }
  default = "applets"
}

variable "db_password" {
  type        = string
  description = "db_password，数据库账号密码，必须包含三种及以上类型：大写字母、小写字母、数字、特殊符号。长度为8～32位。特殊字符包括! @ # $ % ^ & * () _ + - ="
  sensitive   = true
}
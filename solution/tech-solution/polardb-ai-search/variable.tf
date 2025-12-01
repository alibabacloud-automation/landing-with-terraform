# ------------------------------------------------------------------------------
# 模块输入变量
#
# 本文件定义了该 Terraform 模块所有可配置的输入变量
# 每个变量都包含了详细的说明，以帮助用户正确配置模块
# ------------------------------------------------------------------------------

# OSS存储桶名称
variable "bucket_name" {
  type        = string
  description = "bucket_name,在同一可用区下请保持唯一"
  default     = "test-bucket-polar"
}

# PolarDB数据库用户名
variable "account_name" {
  type        = string
  default     = "polar_ai"
  description = "account_name"
  validation {
    condition     = can(regex("^[a-z][a-z0-9_]{0,30}[a-z0-9]$", var.account_name))
    error_message = "数据库用户名必须以字母开头，以字母或数字结尾，只能包含字母、数字和下划线最多32个字符"
  }
}

# PolarDB数据库密码
variable "db_password" {
  type        = string
  sensitive   = true
  description = "account_password"
  #default    = ""
  validation {
    condition     = can(regex("^[0-9A-Za-z_!@#$%^&*()_+\\-=\\+]+$", var.db_password)) && length(var.db_password) >= 8 && length(var.db_password) <= 30
    error_message = "长度8-30，必须包含三项（大写字母、小写字母、数字、 !@#$%^&*()_+-=中的特殊符号）"
  }
}

# PolarDB数据库名称
variable "dbname" {
  type        = string
  default     = "db-test"
  description = "dbname"
  validation {
    condition     = can(regex("^[a-z][a-z0-9_-]{0,62}[a-z0-9]$", var.dbname))
    error_message = "由小写字母、数字、中划线（-）、下划线（_）组成，小写字母或数字结尾，以字母开头，以字母或数字结尾，最长 64 个字符"
  }
}
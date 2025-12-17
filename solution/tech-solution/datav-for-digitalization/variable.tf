# ------------------------------------------------------------------------------
# 模块输入变量
#
# 本文件定义了该 Terraform 模块所有可配置的输入变量
# 每个变量都包含了详细的说明，以帮助用户正确配置模块
# ------------------------------------------------------------------------------

# 数据库账号名称
variable "rds_db_user" {
  type    = string
  default = "user_test"
  validation {
    condition     = can(regex("^[a-z][a-z0-9_]{0,31}$", var.rds_db_user))
    error_message = "由 2 到 32 个小写字母组成，支持小写字母、数字和下划线，以小写字母开头"
  }
  description = "数据库账号"
}

# MySQL数据库密码
variable "db_password" {
  type      = string
  sensitive = true
  #default    = ""
  description = "MySQL数据库密码"
  validation {
    condition     = can(regex("^[0-9A-Za-z_!@#$%^&*()_+\\-=\\+]+$", var.db_password)) && length(var.db_password) >= 8 && length(var.db_password) <= 30
    error_message = "长度8-30，必须包含三项（大写字母、小写字母、数字、 !@#$%^&*()_+-=中的特殊符号）"
  }
}
# ------------------------------------------------------------------------------
# 模块输入变量
#
# 本文件定义了该 Terraform 模块所有可配置的输入变量
# 每个变量都包含了详细的说明，以帮助用户正确配置模块
# ------------------------------------------------------------------------------

# 数据库实例规格
variable "db_instance_class" {
  type    = string
  default = "8C32G"
  validation {
    condition     = contains(["8C32G", "16C64G", "32C128G", "64C256G"], var.db_instance_class)
    error_message = "无效的配置信息，请检查并重新输入"
  }
  description = "数据库实例规格，请在以下规格中选择【8C32G, 16C64G, 32C128G,64C256G】"
}

# RDS数据库用户名
variable "rds_db_user" {
  type    = string
  default = "rds_user"
  validation {
    condition     = can(regex("^[a-z][a-z0-9_]{0,30}[a-z0-9]$", var.rds_db_user))
    error_message = "数据库用户名必须以字母开头，以字母或数字结尾，只能包含字母、数字和下划线最多32个字符"
  }
  description = "RDS数据库账号"
}

# 数据库密码
variable "db_password" {
  type        = string
  sensitive   = true
  description = "数据库密码"
  #default    = ""
  validation {
    condition     = can(regex("^[0-9A-Za-z_!@#$%^&*()_+\\-=\\+]+$", var.db_password)) && length(var.db_password) >= 8 && length(var.db_password) <= 30
    error_message = "长度8-30，必须包含三项（大写字母、小写字母、数字、 !@#$%^&*()_+-=中的特殊符号）"
  }
}

# ClickHouse数据库用户名
variable "click_house_user" {
  type    = string
  default = "ck_user"
  validation {
    condition     = can(regex("^[a-z][a-z0-9_]{0,30}[a-z0-9]$", var.click_house_user))
    error_message = "数据库用户名必须以字母开头，以字母或数字结尾，只能包含字母、数字和下划线最多32个字符"
  }
  description = "ClickHouse数据库账号"
}

# ECS实例类型
variable "ecs_instance_type" {
  type        = string
  default     = "ecs.e-c1m2.large"
  description = "实例类型"
}

# ECS实例密码
variable "ecs_instance_password" {
  type        = string
  description = "ecs实例密码"
  #default    = ""
  sensitive = true
  validation {
    condition     = can(regex("^[0-9A-Za-z_!@#$%^&*()_+\\-=\\+]+$", var.ecs_instance_password)) && length(var.ecs_instance_password) >= 8 && length(var.ecs_instance_password) <= 30
    error_message = "长度8-30，必须包含三项（大写字母、小写字母、数字、 !@#$%^&*()_+-=中的特殊符号）"
  }
}
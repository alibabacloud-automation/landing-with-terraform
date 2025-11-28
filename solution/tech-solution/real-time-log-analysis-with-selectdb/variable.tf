# ------------------------------------------------------------------------------
# 模块输入变量
#
# 本文件定义了该 Terraform 模块所有可配置的输入变量
# 每个变量都包含了详细的说明，以帮助用户正确配置模块
# ------------------------------------------------------------------------------

# 指定ECS实例的规格型号
variable "instance_type" {
  type        = string
  default     = "ecs.g8i.4xlarge"
  description = "ECS实例类型，建议选择配备 16 vCPU 64 GiB 配置的实例"
}

# ECS服务器root账号密码
variable "ecs_instance_password" {
  type        = string
  sensitive   = true
  description = "ECS服务器root账号密码"
  #default    = ""
  validation {
    condition     = can(regex("^[0-9A-Za-z_!@#$%^&*()_+\\-=\\+]+$", var.ecs_instance_password)) && length(var.ecs_instance_password) >= 8 && length(var.ecs_instance_password) <= 30
    error_message = "长度8-30，必须包含三项（大写字母、小写字母、数字、 !@#$%^&*()_+-=中的特殊符号）"
  }
}

# SelectDB实例规格
variable "instance_class" {
  type        = string
  default     = "selectdb.4xlarge"
  description = "SelectDB实例规格"
}

# SelectDB内核版本
variable "selectdb_engine_version" {
  type        = string
  default     = "4.0.4"
  description = "SelectDB内核版本"
  validation {
    condition     = contains(["3.0.12", "4.0.4"], var.selectdb_engine_version)
    error_message = "无效的配置信息，请检查并重新输入"
  }
}

# SelectDB admin账号密码
variable "db_password" {
  type        = string
  sensitive   = true
  description = "SelectDB admin账号密码"
  #default    = ""
  validation {
    condition     = can(regex("^[0-9A-Za-z_!@#$%^&*()_+\\-=\\+]+$", var.db_password)) && length(var.db_password) >= 8 && length(var.db_password) <= 30
    error_message = "长度8-30，必须包含三项（大写字母、小写字母、数字、 !@#$%^&*()_+-=中的特殊符号）"
  }
}
# ------------------------------------------------------------------------------
# 模块输入变量
#
# 本文件定义了该 Terraform 模块所有可配置的输入变量
# 每个变量都包含了详细的说明，以帮助用户正确配置模块
# ------------------------------------------------------------------------------

# 指定ECS实例的规格型号
variable "instance_type" {
  type        = string
  description = "ECS实例类型"
  default     = "ecs.e-c1m4.2xlarge"
}

# ECS实例密码
variable "ecs_instance_password" {
  type      = string
  sensitive = true
  validation {
    condition     = can(regex("^[0-9A-Za-z_!@#$%^&*()_+\\-=\\+]+$", var.ecs_instance_password)) && length(var.ecs_instance_password) >= 8 && length(var.ecs_instance_password) <= 30
    error_message = "长度8-30，必须包含三项（大写字母、小写字母、数字、 !@#$%^&*()_+-=中的特殊符号）"
  }
  description = "ECS实例密码"
  #default = ""
}
# ------------------------------------------------------------------------------
# 模块输入变量 (Module Input Variables)
#
# 本文件定义了该 Terraform 模块所有可配置的输入变量。
# 每个变量都包含了详细的 'description'，以说明其用途、格式和默认值逻辑。
# 请参考这些描述来正确配置模块。
# ------------------------------------------------------------------------------

# 指定创建的ECS云服务器的规格。
variable "ecs_instance_type" {
  type        = string
  default     = "ecs.t6-c1m2.large"
  description = "ECS实例规格"
}

# 用于登录ECS实例的密码。
variable "ecs_instance_password" {
  type        = string
  sensitive   = true
  description = "服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
  # default   = ""
}

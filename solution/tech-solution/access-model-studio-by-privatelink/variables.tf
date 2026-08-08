# ------------------------------------------------------------------------------
# 模块输入变量 (Module Input Variables)
#
# 本文件定义了该 Terraform 模块所有可配置的输入变量。
# 每个变量都包含了详细的 'description'，以说明其用途、格式和默认值逻辑。
# 请参考这些描述来正确配置模块。
# ------------------------------------------------------------------------------

# 北京地域可用区1
variable "bj_zone_id1" {
  type        = string
  description = "北京可用区1"
  default     = "cn-beijing-l"
}

# 北京地域可用区2
variable "bj_zone_id2" {
  type        = string
  description = "北京可用区2"
  default     = "cn-beijing-k"
}

# ECS 实例规格
variable "instance_type" {
  type        = string
  description = "ECS实例规格"
  default     = "ecs.e-c1m2.large"
}

# ECS 实例登录密码
variable "ecs_instance_password" {
  type        = string
  sensitive   = true
  description = "服务器登录密码，长度8-30，必须包含三项（大写字母、小写字母、数字、特殊符号）"
}

# 杭州地域可用区1
variable "hz_zone_id1" {
  type        = string
  description = "杭州可用区1"
  default     = "cn-hangzhou-j"
}

# 杭州地域可用区2
variable "hz_zone_id2" {
  type        = string
  description = "杭州可用区2"
  default     = "cn-hangzhou-k"
}
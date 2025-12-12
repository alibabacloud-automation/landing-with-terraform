# ------------------------------------------------------------------------------
# 模块输入变量 (Module Input Variables)
#
# 本文件定义了该 Terraform 模块所有可配置的输入变量。
# 每个变量都包含了详细的 'description'，以说明其用途、格式和默认值逻辑。
# 请参考这些描述来正确配置模块。
# ------------------------------------------------------------------------------

variable "ecs_instance_type" {
  type        = string
  default     = "ecs.t6-c1m2.large"
  description = "实例类型"
}

variable "ecs_instance_password" {
  type        = string
  sensitive   = true
  description = "服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
  # default   = ""
}

variable "mse_license_key" {
  type        = string
  description = "当前环境 MSE License Key。登录MSE控制台：https://mse.console.aliyun.com，点击治理中心 > 应用治理，在顶部选择地域, 在右上角点击查看License Key，获取MSE License Key。"
  # default   = ""
}
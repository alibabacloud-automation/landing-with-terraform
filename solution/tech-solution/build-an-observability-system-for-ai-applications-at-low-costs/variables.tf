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
  description = "实例类型"
}

# 用于登录ECS实例的密码。
variable "ecs_instance_password" {
  type        = string
  sensitive   = true
  description = "服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
  # default   = ""
}

# 百炼API-KEY
variable "bai_lian_api_key" {
  type        = string
  description = "百炼 API-KEY，需开通百炼模型服务再获取 API-KEY，详情请参考：https://help.aliyun.com/zh/model-studio/developer-reference/get-api-key"
  # default   = ""
}

# ARMS LicenseKey
variable "arms_license_key" {
  type        = string
  description = "当前环境 ARMS License Key。可以通过OpenAPI获取，前往<https://api.aliyun.com/api/ARMS/2019-08-08/DescribeTraceLicenseKey>，输入参数中填写RegionId（部署地域），单击发起调用，获取结果中LicenseKey对应的值。"
  # default   = ""
}


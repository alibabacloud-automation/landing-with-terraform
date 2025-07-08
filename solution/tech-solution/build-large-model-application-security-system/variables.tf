variable "region" {
  type        = string
  default     = "cn-hangzhou"
  description = "地域，例如：cn-hangzhou。所有地域及可用区请参见文档：https://help.aliyun.com/document_detail/40654.html#09f1dc16b0uke"
}
variable "zone_id1" {
  type        = string
  default     = "cn-hangzhou-k"
  description = "可用区ID。选择可用区前请确认该可用区是否支持创建ECS资源的规格。例如：cn-hangzhou-k"
}
variable "instance_type" {
  type        = string
  default     = "ecs.e-c1m2.large"
  description = "实例类型"
}
variable "ecs_instance_password" {
  type        = string
  sensitive   = true
  description = "服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
}
variable "bai_lian_api_key" {
  type        = string
  description = "百炼 API-KEY，需开通百炼模型服务再获取 API-KEY，详情请参考：https://help.aliyun.com/zh/model-studio/developer-reference/get-api-key"
}

variable "region" {
  type    = string
  default = "cn-hangzhou"
}

variable "instance_type" {
  type        = string
  default     = "ecs.t6-c1m2.large"
  description = "实例类型"
}

variable "ecs_instance_password" {
  type        = string
  sensitive   = true
  description = "服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
}

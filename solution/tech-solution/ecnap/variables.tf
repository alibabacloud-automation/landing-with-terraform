variable "ecs_instance_type" {
  type        = string
  description = "ECS实例规格"
  default     = "ecs.t6-c4m1.large"
}

variable "ecs_instance_password" {
  type        = string
  sensitive   = true
  description = "服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
  # default = "Alicloud@123"
}

variable "region" {
  type        = string
  description = "资源部署地域"
  default     = "cn-hangzhou"
}

variable "zone1" {
  type        = string
  description = "交换机可用区1"
  default     = "cn-hangzhou-j"
}

variable "zone2" {
  type        = string
  description = "交换机可用区2，请确保交换机可用区2与交换机可用区1不相同"
  default     = "cn-hangzhou-k"
}




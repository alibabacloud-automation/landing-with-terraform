# Parameters
variable "region_id" {
  description = "请输入地域ID（例如：cn-hangzhou）。"
  default     = "cn-hangzhou"
}
variable "zone_id" {
  type        = string
  description = "交换机可用区ID"
  default     = "cn-hangzhou-k"
}

variable "db_password" {
  type        = string
  description = "Tair数据库密码。长度8-30，必须包含大写字母、小写字母、数字、特殊符号三个；特殊字符包括：!@#$%^&*()_+-="
  sensitive   = true
  validation {
    condition     = can(regex("^[0-9A-Za-z_!@#$%^&*()_+\\-=\\+]+$", var.db_password)) && length(var.db_password) >= 8 && length(var.db_password) <= 30
    error_message = "长度8-30，必须包含三项（大写字母、小写字母、数字、 !@#$%^&*()_+-=中的特殊符号）"
  }
}

variable "ecs_instance_type" {
  type        = string
  description = "ECS 实例类型"
  default     = "ecs.e-c1m2.large"
}

variable "ecs_instance_password" {
  type        = string
  description = "ECS实例密码。服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;<>,.?/ 中的特殊符号）"
  sensitive   = true
  validation {
    condition     = can(regex("^[a-zA-Z0-9-\\(\\)\\`\\~\\!\\@\\#\\$\\%\\^\\&\\*\\_\\-\\+\\=\\|\\{\\}\\[\\]\\:\\;\\<\\>\\,\\.\\?\\/]*$", var.ecs_instance_password)) && length(var.ecs_instance_password) >= 8 && length(var.ecs_instance_password) <= 30
    error_message = "长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;<>,.?/ 中的特殊符号）"
  }
}
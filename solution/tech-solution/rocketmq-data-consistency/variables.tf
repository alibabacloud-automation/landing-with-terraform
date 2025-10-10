variable "region" {
  type    = string
  default = "cn-hangzhou"
}

variable "ecs_instance_type" {
  type        = string
  default     = "ecs.t6-c1m2.large"
  description = "ECS实例规格"
}

variable "ecs_instance_password" {
  type        = string
  sensitive   = true
  description = "服务器登录密码,长度8-30，必须包含三项（大写字母、小写字母、数字、 ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/ 中的特殊符号）"
}

variable "db_instance_type" {
  type        = string
  default     = "mysql.n2.medium.1"
  description = "RDS实例规格"
}

variable "db_account_name" {
  type        = string
  default     = "db_normal_account"
  description = "RDS数据库账号"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "请输入RDS数据库密码。密码长度为8-32位，需包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*()_+-=）。如果在本教程中重复配置，请确保 MySQL 数据库密码与模板首次执行时设置的密码完全相同，否则配置结果不可用。"
}

variable "rocketmq_username" {
  type        = string
  default     = "rmquser"
  description = "请输入RocketMQ用户名。用户名长度为4-16位，只能包含字母、数字和下划线。"
}

variable "rocketmq_password" {
  type        = string
  sensitive   = true
  description = "请输入RocketMQ密码。密码长度为8-32位，需包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*()_+-=）。"
}

variable "app_demo_username" {
  type        = string
  default     = "appuser"
  description = "请输入登录应用演示账户的用户名。用户名长度为4-16位，只能包含字母、数字和下划线。"
}

variable "app_demo_password" {
  type        = string
  sensitive   = true
  default     = "apppassword"
  description = "请输入登录应用演示账户的密码。密码长度为8-32位，需包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*()_+-=）。"
}
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
  type = string
  # default     = "mysql.n2m.medium.2c"
  # default     = "mysql.n1e.small.1"
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

variable "redis_instance_type" {
  type        = string
  default     = "redis.shard.small.2.ce"
  description = "Redis实例规格"
}

variable "redis_password" {
  type        = string
  sensitive   = true
  description = "请输入Redis密码。密码长度为8-32位，需包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*()_+-=）。"
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

variable "mse_license_key" {
  type        = string
  description = "当前环境 MSE License Key。登录MSE控制台：https://mse.console.aliyun.com，点击治理中心 > 应用治理，在顶部选择地域, 在右上角点击查看License Key，获取MSE License Key。"
}

variable "arms_license_key" {
  type        = string
  description = "当前环境 ARMS License Key。登录ARMS 管理控制台：https://arms.console.aliyun.com，点击接入中心 > 服务端应用 > Java 应用监控。在开始接入页签中选择所属环境类型设置为手动安装，在安装Agent步骤中获取变量-Darms.licenseKey对应的值。"
}

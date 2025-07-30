variable "region" {
  description = "地域"
  type        = string
  default     = "cn-hangzhou"
}

variable "demo_user_name" {
  type        = string
  description = "在浏览器中登录示例应用程序时的用户名。"
  default     = "demo-user-example"
}

variable "demo_user_password" {
  type        = string
  description = "登录示例应用程序时的登录密码，必须包含三种及以上类型：大写字母、小写字母、数字、特殊符号。长度为8～32位。特殊字符包括!@#$%^&*()_+-="
  sensitive   = true
  default     = "Demo123.."
}

variable "ecs_instance_password" {
  type        = string
  description = "服务器登录密码，长度8-30，必须包含三项（大写字母、小写字母、数字、特殊符号）"
  sensitive   = true
}

variable "db_user_name" {
  type        = string
  description = "RDS数据库账号，由2到32个小写字母组成，支持小写字母、数字和下划线，以小写字母开头"
  default     = "user_test"
}

variable "db_password" {
  type        = string
  description = "RDS数据库密码，必须包含三种及以上类型：大写字母、小写字母、数字、特殊符号。长度为8～32位。特殊字符包括!@#$%^&*()_+-="
  sensitive   = true
}

variable "scheduler_x_endpoint" {
  type        = string
  description = "SchedulerX接入地址，请输入在SchedulerX控制台的接入配置中获取的接入地址"
  default     = "addr-hz-internal.edas.aliyun.com"
}

variable "scheduler_x_namespace" {
  type        = string
  description = "SchedulerX命名空间，请输入在SchedulerX控制台的接入配置中获取的命名空间"
  default     = "00000000-00000000-00000000-00000000"
}

variable "scheduler_x_group_id" {
  type        = string
  description = "SchedulerX应用ID，请输入在SchedulerX控制台的接入配置中获取的应用ID"
  default     = "test"
}

variable "scheduler_x_app_key" {
  type        = string
  description = "SchedulerX应用密钥，请输入在SchedulerX控制台的接入配置中获取的应用密钥"
  sensitive   = true
  default     = "SzcxxxxxxxxxxPw"
}

variable "common_name" {
  type        = string
  description = "应用名称"
  default     = "scheduler-demo"
}
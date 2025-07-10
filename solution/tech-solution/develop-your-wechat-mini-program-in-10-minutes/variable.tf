# Parameters
variable "zone_id" {
  type        = string
  description = "请输入可用区ID（例如：cn-hangzhou-k）。请确保该可用区支持您要创建的ECS资源规格。"
  default     = "cn-hangzhou-k"
}

variable "vpc_cidr_block" {
  description = "请输入VPC的CIDR块（支持的值包括：192.168.0.0/16、172.16.0.0/12、10.0.0.0/8）。这是您的虚拟私有云的地址范围。"
  default     = "192.168.0.0/16"
  validation {
    condition     = contains(["192.168.0.0/16", "172.16.0.0/12", "10.0.0.0/8"], var.vpc_cidr_block)
    error_message = "无效的VPC CIDR块，请检查并重新输入。"
  }
}

variable "vswitch_cidr_block" {
  description = "请输入交换机的CIDR块（例如：192.168.0.0/24）。这是您虚拟交换机的地址范围。"
  default     = "192.168.0.0/24"
}

variable "ecs_instance_type" {
  description = "请输入ECS实例类型（例如：ecs.e-c1m2.large）。请根据实际需求选择合适的实例规格。"
  default     = "ecs.e-c1m2.large"
}

variable "instance_password" {
  description = "请输入服务器登录密码。密码长度为8-30位，必须包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*_-+=|{}[]:;'<>,.?/）。"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "请输入RDS实例规格（例如：mysql.n2m.medium.2c）。根据您的数据库负载选择合适的规格。"
  default     = "mysql.n2m.medium.2c"
}

variable "db_name" {
  description = "请输入数据库名称（由小写字母、数字及特殊字符 -_ 组成，以字母开头，字母或数字结尾，最多64个字符）。"
  default     = "wordpress"
  validation {
    condition     = regex("^[a-z][a-z0-9-_]{0,62}[a-z0-9]$", var.db_name) != ""
    error_message = "数据库名称格式不正确。名称应由小写字母、数字及特殊字符 -_ 组成，以字母开头，字母或数字结尾，最多64个字符。"
  }
}

variable "db_user" {
  description = "请输入RDS数据库用户名（长度为2-16个字符，仅允许小写字母、数字和下划线，必须以字母开头，以字母或数字结尾）。"
  default     = "dbuser"
  validation {
    condition     = regex("^[a-z][a-z0-9_]{1,15}$", var.db_user) != ""
    error_message = "用户名格式不正确。用户名长度应为2-16个字符，仅允许小写字母、数字和下划线，必须以字母开头，以字母或数字结尾。"
  }
}

variable "db_password" {
  description = "请输入RDS数据库密码。密码长度为8-32位，需包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*()_+-=）。如果在本教程中重复配置，请确保 MySQL 数据库密码与模板首次执行时设置的密码完全相同，否则配置结果不可用。"
  type        = string
  sensitive   = true
}

variable "word_press_user_name" {
  description = "请输入WordPress管理员用户名（建议使用独特的用户名以增强安全性）。"
  default     = "admin"
}

variable "word_press_password" {
  description = "请输入WordPress管理员密码。密码长度为8-32位，需包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*()_+-=）。"
  type        = string
  sensitive   = true
}

variable "word_press_user_email" {
  description = "请输入WordPress管理员邮箱（用于系统通知和找回密码）。"
  default     = "admin@example.com"
}
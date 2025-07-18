# Parameters
variable "region_id" {
  description = "请输入地域ID（例如：cn-hangzhou）。"
  default     = "cn-hangzhou"
}

variable "ecs_instance_password" {
  description = "请输入服务器登录密码。密码长度为8-30位，必须包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*_-+=|{}[]:;'<>,.?/）。"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.ecs_instance_password) >= 8 && length(var.ecs_instance_password) <= 30 && can(regex("^[0-9A-Za-z\\_\\-\\&:;'<>,=%`~!@#\\(\\)\\$\\^\\*\\+\\|\\{\\}\\[\\]\\.\\?\\/]+$", var.ecs_instance_password))
    error_message = "密码长度必须在8-30个字符之间，只能包含英文字母、数字和特殊字符!@#$%^&*()_+-=|{}[]:;'<>,.?/~`%=。"
  }
}

variable "db_name" {
  description = "请输入自建MongoDB数据库名称（由小写字母、数字及特殊字符 -_ 组成，以小写字母开头，小写字母或数字结尾，最多64个字符）。"
  type        = string
  default     = "mongodb_transfer_test"
  validation {
    condition     = can(regex("^([a-z][a-z0-9_-]{0,62}[a-z0-9])$", var.db_name)) && !contains(["admin", "config", "local", "test"], var.db_name)
    error_message = "数据库名称格式不正确。名称应由小写字母、数字及特殊字符 -_ 组成，以小写字母开头，小写字母或数字结尾，最多64个字符，且不能为admin、config、local、test。"
  }
}

variable "db_user_name" {
  description = "请输入自建MongoDB数据库账号（长度为2-16个字符，仅允许小写字母、大写字母、数字和下划线，必须以字母开头，以字母或数字结尾）。"
  type        = string
  default     = "mongouser"
  validation {
    condition     = length(var.db_user_name) >= 2 && length(var.db_user_name) <= 16 && can(regex("^[a-zA-Z][a-zA-Z0-9_]*[a-zA-Z0-9]$", var.db_user_name))
    error_message = "用户名格式不正确。用户名应由字母、数字和下划线组成，必须以字母开头，以字母或数字结尾，长度为2-16个字符。"
  }
}

variable "db_password" {
  description = "请输入自建MongoDB数据库密码。密码长度为8-32位，需包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*()_+-=）。"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.db_password) >= 8 && length(var.db_password) <= 32 && can(regex("^[0-9A-Za-z\\_\\-\\&:;'<>,=%`~!@#\\(\\)\\$\\^\\*\\+\\|\\{\\}\\[\\]\\.\\?\\/]+$", var.db_password))
    error_message = "密码长度必须在8-32个字符之间，只能包含英文字母、数字和特殊字符!@#$%^&*()_+-=|{}[]:;'<>,.?/~`%=。"
  }
}

variable "mongodb_instance_class" {
  description = "请输入MongoDB实例规格（例如：mdb.shard.2x.xlarge.d）。根据您的数据库负载选择合适的规格。"
  type        = string
  default     = "mdb.shard.2x.xlarge.d"
}

variable "mongodb_password" {
  description = "请输入MongoDB Root密码。密码长度为6-32位，需包含大写字母、小写字母、数字和特殊字符（如：!@#$%^&*()_+-=）。"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.mongodb_password) >= 6 && length(var.mongodb_password) <= 32 && can(regex("^[0-9A-Za-z\\_\\-\\&:;'<>,=%`~!@#\\(\\)\\$\\^\\*\\+\\|\\{\\}\\[\\]\\.\\?\\/]+$", var.mongodb_password))
    error_message = "MongoDB Root密码长度必须在6-32个字符之间，只能包含英文字母、数字和特殊字符!@#$%^&*()_+-=|{}[]:;'<>,.?/~`%=。"
  }
}
variable "region" {
  description = "地域"
  type        = string
  default     = "cn-hangzhou"
}

variable "rds_db_user" {
  type        = string
  description = "RDS数据库账号。由2到16个小写字母组成，下划线。必须以字母开头，以字母数字字符结尾。"
  default     = "demouser123"
  validation {
    condition     = can(regex("^[a-z][a-z0-9_]{1,15}[a-z0-9]$", var.rds_db_user))
    error_message = "由2到16个小写字母组成，下划线。必须以字母开头，以字母数字字符结尾。"
  }
}

variable "db_name" {
  type        = string
  description = "RDS数据库名称。由2到16个小写字母组成，下划线。必须以字母开头，以字母数字字符结尾。"
  default     = "demodb"
  validation {
    condition     = can(regex("^[a-z][a-z0-9_]{1,15}[a-z0-9]$", var.db_name))
    error_message = "由2到16个小写字母组成，下划线。必须以字母开头，以字母数字字符结尾。"
  }
}

variable "db_password" {
  type        = string
  description = "RDS数据库密码，由字母、数字、下划线（_）组成，长度为8~32个字符，必须包含3种不同类型的字符。"
  sensitive   = true
}

variable "dts_job_name" {
  type        = string
  description = "同步任务名称。建议配置具有业务意义的名称（无唯一性要求），便于后续识别。"
  default     = "mysql2redis_dts"
}

variable "redis_instance_class" {
  type        = string
  description = "Tair规格。选择机型前请先确认当前可用区下该机型是否有库存，为节省测试成本，推荐使用2GB的规格，例如：tair.rdb.2g"
  default     = "tair.rdb.2g"
}

variable "redis_password" {
  type        = string
  description = "实例密码。长度8-32个字符,可包含大小字母、数字及特殊符号（包含：!@#$%^&*()_+-=）"
  sensitive   = true
}
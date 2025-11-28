# ------------------------------------------------------------------------------
# 模块输入变量
#
# 本文件定义了该 Terraform 模块所有可配置的输入变量
# 每个变量都包含了详细的说明，以帮助用户正确配置模块
# ------------------------------------------------------------------------------

# RDS实例规格
variable "db_instance_class" {
  type        = string
  default     = "pg.n4.2c.1m"
  nullable    = false
  description = "实例规格"
}

# RDS数据库账号
variable "rds_db_user" {
  type        = string
  default     = "test_user"
  nullable    = false
  description = "RDS数据库账号"
}

# RDS数据库名称
variable "db_name" {
  type        = string
  default     = "food_test"
  nullable    = false
  description = "RDS数据库名称"
}

# RDS数据库密码
variable "db_password" {
  type        = string
  sensitive   = true
  description = "RDS数据库密码"
  #default    = ""
}
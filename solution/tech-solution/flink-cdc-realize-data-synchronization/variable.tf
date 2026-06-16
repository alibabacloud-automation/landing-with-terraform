# ------------------------------------------------------------------------------
# 模块输入变量
#
# 本文件定义了该 Terraform 模块所有可配置的输入变量
# 每个变量都包含了详细的说明，以帮助用户正确配置模块
# ------------------------------------------------------------------------------

# RDS实例的规格型号
variable "dbinstance_class" {
  type        = string
  description = "RDS实例规格"
  default     = "mysql.n2.medium.1"
}

# RDS数据库的账号名称
variable "db_user_name" {
  type        = string
  default     = "db_user"
  nullable    = false
  description = "RDS数据库账号"
}

# RDS数据库的密码
variable "db_password" {
  type        = string
  sensitive   = true
  description = "RDS数据库密码"
  #default    = ""
}

# OSS存储空间的名称
variable "bucket_name" {
  type        = string
  description = "OSS存储空间名称"
  default     = "flink-cdc"
}

# OSS文件目录名称
variable "directory_name" {
  type        = string
  default     = "warehouse"
  nullable    = false
  description = "Bucket 文件目录名称"
}

# Flink实例的名称
variable "flink_instance_name" {
  type        = string
  description = "Flink实例名称"
  default     = "flink-cdc-test"
}
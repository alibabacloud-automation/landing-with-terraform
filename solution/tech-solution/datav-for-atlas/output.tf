# ------------------------------------------------------------------------------
# 模块输出值
#
# 本文件定义了模块执行成功后返回给调用方的值
# 这些输出可以被其他 Terraform 配置引用，或在 apply 命令结束后显示给用户
# ------------------------------------------------------------------------------

# 输出PostgreSQL实例的公网连接地址
output "pg_public_connection_string" {
  value       = alicloud_db_connection.public.connection_string
  description = "PostgreSQL 外网连接地址"
}

# 输出数据库账号。
output "account_name" {
  value       = var.rds_db_user
  description = "数据库账号"
}

# 输出数据库密码。
output "account_password" {
  value       = var.db_password
  sensitive   = true
  description = "数据库密码"
}

# 输出数据库名称。
output "dbname" {
  value       = var.db_name
  description = "数据库名称"
}
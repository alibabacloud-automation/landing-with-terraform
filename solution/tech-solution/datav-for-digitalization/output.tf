# ------------------------------------------------------------------------------
# 模块输出值
#
# 本文件定义了模块执行成功后返回给调用方的值
# 这些输出可以被其他 Terraform 配置引用，或在 apply 命令结束后显示给用户
# ------------------------------------------------------------------------------

# 输出创建的RDS实例ID
output "DBInstanceId" {
  value       = alicloud_db_instance.rds_instance.id
  description = "RDS 实例 ID"
}

# 输出RDS实例的内网连接地址
output "InnerConnectionString" {
  value       = alicloud_db_instance.rds_instance.connection_string
  description = "RDS 内网连接地址"
}

# 输出RDS实例的内网端口号
output "InnerPort" {
  value       = alicloud_db_instance.rds_instance.port
  description = "RDS 内网端口"
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
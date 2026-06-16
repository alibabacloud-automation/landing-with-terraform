# ------------------------------------------------------------------------------
# 模块输出值
#
# 本文件定义了模块执行成功后返回给调用方的值
# 这些输出可以被其他 Terraform 配置引用，或在 apply 命令结束后显示给用户
# ------------------------------------------------------------------------------

# 输出 RDS 实例 ID
output "rds_instance_id" {
  value       = alicloud_db_instance.rdsdbinstance.id
  description = "RDS 实例 ID"
}

# 输出RDS实例的内网连接地址
output "mysql_host" {
  value       = alicloud_db_instance.rdsdbinstance.connection_string
  description = "内网连接地址"
}

# 输出数据库账号
output "db_username" {
  value       = var.db_user_name
  description = "数据库账号"
}

# 输出数据库密码
output "db_password" {
  value       = var.db_password
  sensitive   = true
  description = "数据库密码"
}

# 输出 OSS 存储空间的名称
output "bucket_name" {
  value       = alicloud_oss_bucket.bucket.bucket
  description = "OSS 存储空间的名称"
}

# 输出 OSS 文件目录名称
output "oss_prefix" {
  value       = var.directory_name
  description = "OSS 文件目录名称"
}
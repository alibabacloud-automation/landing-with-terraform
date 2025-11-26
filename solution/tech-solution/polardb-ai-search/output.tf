# ------------------------------------------------------------------------------
# 模块输出值
#
# 本文件定义了模块执行成功后返回给调用方的值
# 这些输出可以被其他 Terraform 配置引用，或在 apply 命令结束后显示给用户
# ------------------------------------------------------------------------------

# 输出OSS存储桶名
output "bucket_name" {
  value       = alicloud_oss_bucket.ossbucket.bucket
  description = "对象存储存储桶名"
}

# 输出PolarDB数据库用户名
output "account_name" {
  value       = var.account_name
  description = "PolarDB 数据库用户名"
}

# 输出PolarDB数据库密码
output "account_password" {
  value       = var.db_password
  sensitive   = true
  description = "PolarDB 数据库密码"
}

# 输出PolarDB数据库名称
output "dbname" {
  value       = var.dbname
  description = "PolarDB 数据库名称"
}

# 输出PolarDB数据库公网地址
output "connection_string" {
  value       = format("%s:5432", alicloud_polardb_endpoint_address.dbcluster_endpoint_address.connection_string)
  description = "PolarDB 数据库的公网地址"
}
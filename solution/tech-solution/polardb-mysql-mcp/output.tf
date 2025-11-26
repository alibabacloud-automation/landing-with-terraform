# ------------------------------------------------------------------------------
# 模块输出值
#
# 本文件定义了模块执行成功后返回给调用方的值
# 这些输出可以被其他 Terraform 配置引用，或在 apply 命令结束后显示给用户
# ------------------------------------------------------------------------------

# 输出PolarDB集群的访问地址
output "polardb_cluster_address" {
  value = format("https://polardb.console.aliyun.com/%s/cluster/%s/baseInfo","cn-hangzhou", alicloud_polardb_cluster.polardb_cluster.id)
  description = "PolarDB访问地址"
}

# 输出PolarDB MySQL的用户名称
output "db_username" {
  value       = var.account_name
  description = "PolarDB MySQL的用户名称"
}

# 输出PolarDB MySQL的用户密码
output "db_password" {
  value       = var.db_password
  sensitive   = true
  description = "PolarDB MySQL的用户密码"
}

# 输出PolarDB 数据库名称
output "db_name" {
  value       = var.dbname
  description = "PolarDB 数据库名称"
}

# 输出PolarDB 数据库的公网连接地址
output "connection_string" {
  value = format("%s", alicloud_polardb_endpoint_address.dbcluster_endpoint_address.connection_string)
  description = "PolarDB 数据库公网连接地址"
}
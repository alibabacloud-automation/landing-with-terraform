## here are the updates to merge:
# ECS相关输出
output "ecs_login_address" {
  description = "ECS登录地址"
  value       = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${data.alicloud_regions.current.regions[0].id}&instanceId=${alicloud_instance.ecs_instance.id}"
}

output "ecs_public_ip_address" {
  description = "ECS公网IP地址"
  value       = alicloud_instance.ecs_instance.public_ip
}

# RDS相关输出
output "rds_database_endpoint" {
  description = "RDS数据库连接地址"
  value       = alicloud_db_instance.rds_instance.connection_string
}

output "rds_database_name" {
  description = "RDS数据库名称"
  value       = alicloud_db_database.rds_database.name
}

output "rds_database_user_name" {
  description = "RDS数据库用户名"
  value       = var.db_user_name
}

# Redis相关输出
output "redis_account_name" {
  description = "Redis数据库用户名"
  value       = var.redis_account_name
}

output "redis_endpoint" {
  description = "Redis数据库连接地址"
  value       = alicloud_kvstore_instance.redis_instance.private_connection_prefix
}

# 获取当前区域信息的数据源
data "alicloud_regions" "current" {}
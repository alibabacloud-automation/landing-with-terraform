# ------------------------------------------------------------------------------
# 模块输出值
#
# 本文件定义了模块执行成功后返回给调用方的值
# 这些输出可以被其他 Terraform 配置引用，或在 apply 命令结束后显示给用户
# ------------------------------------------------------------------------------

# 输出创建的VPC资源ID
output "vpc_id" {
  value = alicloud_vpc.vpc.id
}

# 输出创建的RDS实例ID
output "rds_instance_id" {
  value = alicloud_db_instance.rds_instance.id
}

# 输出创建的ClickHouse集群ID
output "click_house_cluster_id" {
  value = alicloud_click_house_db_cluster.click_house.id
}

# 输出创建的ECS实例ID
output "ecs_instance_id" {
  value = alicloud_instance.ecs_instance.id
}

# 输出RDS数据库用户名
output "db_username" {
  value       = var.rds_db_user
  description = "RDS数据库用户名"
}

# 输出RDS数据库密码
output "db_password" {
  value       = var.db_password
  description = "RDS 数据库密码"
  sensitive   = true
}

# 输出ClickHouse数据库用户名
output "ck_db_name" {
  value       = var.click_house_user
  description = "ClickHouse 数据库用户名"
}

# 输出ClickHouse数据库密码
output "ck_db_password" {
  value       = var.db_password
  description = "ClickHouse 数据库密码"
  sensitive   = true
}

# 输出ECS实例密码
output "ecs_instance_password" {
  value       = var.ecs_instance_password
  description = "ECS 实例密码"
  sensitive   = true
}        
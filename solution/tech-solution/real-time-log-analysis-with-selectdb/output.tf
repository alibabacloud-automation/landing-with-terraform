# ------------------------------------------------------------------------------
# 模块输出值
#
# 本文件定义了模块执行成功后返回给调用方的值
# 这些输出可以被其他 Terraform 配置引用，或在 apply 命令结束后显示给用户
# ------------------------------------------------------------------------------

# 输出ECS登录用户
output "ecs_account" {
  description = "ECS登录用户"
  value       = "root"
}

# 输出ECS用户root密码
output "ecs_login_password" {
  description = "ECS用户root密码"
  value       = var.ecs_instance_password
  sensitive   = true
}

# 输出SelectDB登录用户
output "selectdb_account" {
  description = "SelectDB登录用户"
  value       = "admin"
}

# 输出SelectDB用户admin密码
output "selectdb_login_password" {
  description = "SelectDB用户admin密码"
  value       = var.db_password
  sensitive   = true
}

# 输出SelectDB VPC地址
output "selectdb_vpc_connection_string" {
  description = "SelectDB VPC地址"
  value       = alicloud_selectdb_db_instance.selectdb_instance.instance_net_infos[0].connection_string
}
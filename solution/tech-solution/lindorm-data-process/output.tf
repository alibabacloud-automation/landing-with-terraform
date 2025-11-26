# ------------------------------------------------------------------------------
# 模块输出值
#
# 本文件定义了模块执行成功后返回给调用方的值
# 这些输出可以被其他 Terraform 配置引用，或在 apply 命令结束后显示给用户
# ------------------------------------------------------------------------------

# 输出 Lindorm 实例 ID
output "lindorm_instance_id" {
  value       = alicloud_lindorm_instance.lindorm_instance.id
  description = "Lindorm 实例 ID"
}

# 输出 ECS 实例 ID
output "ecs_instance_id" {
  value       = alicloud_instance.ecs_instance.id
  description = "ECS 实例 ID"
}


# 输出 ECS 登录地址
output "ecs_login_address" {
  description = "ECS登录地址"
  value       = format("https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=%s&instanceId=%s","cn-hangzhou",alicloud_instance.ecs_instance.id)
}

# 输出 ECS 实例用户名
output "ecs_instance_username" {
  value       = "root"
  description = "ECS 实例用户名"
}

# 输出 ECS 实例密码
output "ecs_instance_password" {
  value       = var.instance_password
  sensitive   = true
  description = "ECS 实例密码"
}
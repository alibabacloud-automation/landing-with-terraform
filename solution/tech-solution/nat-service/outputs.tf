# ------------------------------------------------------------------------------
# 模块输出值 (Module Outputs)
#
# 本文件定义了模块执行成功后返回给调用方的值。
# 这些输出可以被其他 Terraform 配置引用，或在 apply 命令结束后显示给用户。
# ------------------------------------------------------------------------------

# ECS1登录地址
output "ecs_login_address1" {
  description = "ECS1 登录地址"
  value       = format("https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=%s&instanceId=%s", var.region, alicloud_instance.ecs_instance1.id)
}

# ECS2登录地址
output "ecs_login_address2" {
  description = "ECS2 登录地址"
  value       = format("https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=%s&instanceId=%s", var.region, alicloud_instance.ecs_instance2.id)
}

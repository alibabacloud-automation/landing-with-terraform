# ------------------------------------------------------------------------------
# 模块输出值 (Module Outputs)
#
# 本文件定义了模块执行成功后返回给调用方的值。
# 这些输出可以被其他 Terraform 配置引用，或在 apply 命令结束后显示给用户。
# ------------------------------------------------------------------------------

output "ecs_login_address" {
  description = "部署应用的ECS实例的登录地址。登录后执行"
  value       = format("https://ecs-workbench.aliyun.com/?from=ecs&instanceType=ecs&regionId=%s&instanceId=%s&resourceGroupId=", local.region, alicloud_instance.ecs_instance.id)
}

output "DemoUrl" {
  description = "应用Web页面访问地址"
  value       = "http://${alicloud_instance.ecs_instance.public_ip}:80"
}
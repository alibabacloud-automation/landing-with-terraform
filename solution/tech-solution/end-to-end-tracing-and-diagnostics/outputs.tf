# ------------------------------------------------------------------------------
# 模块输出值 (Module Outputs)
#
# 本文件定义了模块执行成功后返回给调用方的值。
# 这些输出可以被其他 Terraform 配置引用，或在 apply 命令结束后显示给用户。
# ------------------------------------------------------------------------------

output "web_url" {
  description = "商品秒杀页面地址。(The address of the product flash sale page.)"
  value       = "http://${alicloud_instance.ecs_instance.public_ip}"
}

output "ecs_login_address" {
  description = "部署应用的ECS实例的登录地址。"
  value       = format("https://ecs-workbench.aliyun.com/?from=ecs&instanceType=ecs&regionId=%s&instanceId=%s&resourceGroupId=", local.region, alicloud_instance.ecs_instance.id)
}

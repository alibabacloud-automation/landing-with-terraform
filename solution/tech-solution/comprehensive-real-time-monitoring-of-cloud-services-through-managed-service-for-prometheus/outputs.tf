output "web_url" {
  description = "商品秒杀页面地址。(The address of the product flash sale page.)"
  value       = "http://${alicloud_instance.ecs_instance.public_ip}"
}

output "ecs_login_address" {
  description = "部署应用的ECS实例的登录地址。"
  value       = format("https://ecs-workbench.aliyun.com/?from=ecs&instanceType=ecs&regionId=%s&instanceId=%s&resourceGroupId=", var.region, alicloud_instance.ecs_instance.id)
}

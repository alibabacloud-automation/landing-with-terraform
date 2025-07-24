# Outputs
output "ecs_login_address_1" {
  description = "ECS登录地址"
  value       = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${data.alicloud_regions.current.regions.0.id}&instanceId=${alicloud_instance.ecs_instance.id}"
}

data "alicloud_regions" "current" {
  current = true
}
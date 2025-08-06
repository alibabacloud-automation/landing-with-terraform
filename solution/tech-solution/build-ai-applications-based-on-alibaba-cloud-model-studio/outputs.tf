output "web_url" {
  description = "Web访问地址"
  value       = "http://${alicloud_instance.ecs_instance.public_ip}"
}

output "ecs_login_address" {
  description = "ECS登录地址"
  value       = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${data.alicloud_regions.current.regions.0.id}&instanceId=${alicloud_instance.ecs_instance.id}"
}

// Data source to get current region
data "alicloud_regions" "current" {
  current = true
} 
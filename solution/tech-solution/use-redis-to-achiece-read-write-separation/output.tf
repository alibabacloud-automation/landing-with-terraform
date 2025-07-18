# Outputs
output "ecs_login_address" {
  description = "ECS登录地址"
  value       = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${data.alicloud_regions.current.regions[0].id}&instanceId=${alicloud_instance.ecs_instance.id}"
}

output "redis_connection_address" {
  description = "Redis连接地址"
  value       = alicloud_kvstore_instance.redis.connection_domain
}

output "ecs_public_ip" {
  description = "ECS公网IP"
  value       = alicloud_instance.ecs_instance.public_ip
}

data "alicloud_regions" "current" {
  current = true
}
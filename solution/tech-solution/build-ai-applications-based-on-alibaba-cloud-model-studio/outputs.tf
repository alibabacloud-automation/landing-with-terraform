output "web_url" {
  description = <<EOT
  {
    "zh-cn": "Web 访问地址。",
    "en": "The Addresses of Web."
  }
  EOT
  value       = "http://${alicloud_instance.ecs_instance.public_ip}"
}

output "ecs_login_address" {
  description = <<EOT
  {
    "zh-cn": "ECS登录地址。",
    "en": "Ecs login address."
  }
  EOT
  value       = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${data.alicloud_regions.current.regions.0.id}&instanceId=${alicloud_instance.ecs_instance.id}"
}

// Data source to get current region
data "alicloud_regions" "current" {
  current = true
}

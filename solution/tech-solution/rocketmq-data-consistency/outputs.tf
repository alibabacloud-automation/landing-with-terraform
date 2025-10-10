output "web_url" {
  description = "示例应用页面地址。(The address of the demo webpage.)"
  value       = "http://${alicloud_instance.ecs_instance_provider.public_ip}/login"
}

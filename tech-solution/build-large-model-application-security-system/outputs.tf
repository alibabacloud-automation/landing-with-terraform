output "web_url" {
  description = "Web 访问地址"
  value       = format("http://%s", alicloud_instance.ecs_instance.public_ip)
}
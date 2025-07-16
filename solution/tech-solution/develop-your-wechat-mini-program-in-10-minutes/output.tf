# Outputs
output "wordpress_url" {
  description = "Wordpress 博客访问地址。"
  value       = "http://${alicloud_instance.ecs_instance.public_ip}/wp-admin"
}
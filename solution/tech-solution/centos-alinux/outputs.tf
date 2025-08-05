output "wordpress_url" {
  description = "Wordpress default address"
  value       = "http://${alicloud_instance.ecs_instance.public_ip}"
}
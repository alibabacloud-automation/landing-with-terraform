# Outputs
output "wordpress_url" {
  value = "http://${alicloud_instance.ecs_instance.public_ip}/wp-admin"
}
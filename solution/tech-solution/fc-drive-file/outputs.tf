output "demo_url" {
  description = "Demo address."
  value       = "http://${alicloud_instance.ecs_instance.public_ip}"
}

output "demo_user_name" {
  description = "Login Username."
  value       = var.demo_user_name
}
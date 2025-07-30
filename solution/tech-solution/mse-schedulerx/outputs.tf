output "DemoUserName" {
  description = "Login Username."
  value       = var.demo_user_name
}

output "DemoUrl" {
  description = "Demo URL."
  value       = "http://${alicloud_instance.ecs[0].public_ip}/schedulerx-demo"
}
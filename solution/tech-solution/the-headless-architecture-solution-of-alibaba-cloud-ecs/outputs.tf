output "ecs_backend_login_address" {
  description = "后端应用的ECS实例的登录地址。通过此地址登录ECS后，在本地验证后端应用部署成功的命令为：curl -I http://localhost:8080/api/getEcsReleaseNotes"
  value       = format("https://ecs-workbench.aliyun.com/?from=ecs&instanceType=ecs&regionId=%s&instanceId=%s&resourceGroupId=", var.region, alicloud_instance.ecs_instance_be_2.id)
}

output "ecs_frontend_login_address" {
  description = "前端应用的ECS实例的登录地址。通过此地址登录ECS后，在本地验证前端应用部署成功的命令为：curl -I http://localhost:80/；进一步验证请求能成功转发到后端应用的命令：curl -I http://localhost:80/api/getEcsReleaseNotes"
  value       = format("https://ecs-workbench.aliyun.com/?from=ecs&instanceType=ecs&regionId=%s&instanceId=%s&resourceGroupId=", var.region, alicloud_instance.ecs_instance_fe_1.id)
}

output "web_url" {
  description = "示例网站地址/Sample website address"
  value       = "http://${alicloud_alb_load_balancer.frontend_alb.dns_name}"
}

output "frontend_dns_name" {
  description = "前端ALB的DNS名称。"
  value       = alicloud_alb_load_balancer.frontend_alb.dns_name
}

output "backend_dns_name" {
  description = "后端ALB的DNS名称。"
  value       = alicloud_alb_load_balancer.backend_alb.dns_name
}
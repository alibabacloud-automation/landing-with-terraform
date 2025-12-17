output "ecs_login_address" {
  description = "部署应用的ECS实例的登录地址。登录后执行"
  value       = format("https://ecs-workbench.aliyun.com/?from=ecs&instanceType=ecs&regionId=%s&instanceId=%s&resourceGroupId=", local.region, alicloud_instance.ecs_instance.id)
}

output "ecs_public_ip" {
  description = <<EOF
  为确保可以从公网访问，请配置ECS的安全组对所有IP开放8000端口（即在main.tf中，将cidr_ip改为"0.0.0.0/0"）。
  接口调用示例（将<ecs_public_ip>用实际值替换）：
  curl http://<ecs_public_ip>:8000/docs # 查看应用信息
  curl -X 'POST' 'http://<ecs_public_ip>:8000/agent/invoke' -H 'Content-Type: application/json' -d '{"input": {"input": "北京天气怎么样？"}}' # 调用大模型，等待返回结果。
  EOF
  value       = alicloud_instance.ecs_instance.public_ip
}
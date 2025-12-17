output "ecs_login_address" {
  description = "生成日志的ECS实例的登录地址。通过此地址登录ECS后，在本地查看生成日志文件的命令为：tail -f /var/log/nginx/access.log"
  value       = format("https://ecs-workbench.aliyun.com/?from=ecs&instanceType=ecs&regionId=%s&instanceId=%s&resourceGroupId=", var.region, alicloud_instance.ecs_instance.id)
}
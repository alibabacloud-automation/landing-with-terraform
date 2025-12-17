output "ecs_login_address" {
  description = "生成日志的ECS实例的登录地址。通过此地址登录ECS后，在本地查看生成日志文件的命令为：tail -f /tmp/sls-monitor-test.log"
  value       = format("https://ecs-workbench.aliyun.com/?from=ecs&instanceType=ecs&regionId=%s&instanceId=%s&resourceGroupId=", var.region, alicloud_instance.ecs_instance.id)
}

output "sls_logsearch_url" {
  description = "SLS日志查询入口"
  value       = format("https://sls.console.aliyun.com/lognext/project/%s/logsearch/%s?slsRegion=%s", alicloud_log_project.sls_project.project_name, alicloud_log_store.sls_log_store.logstore_name, var.region)
}

output "kibana_management_url" {
  description = "Kibana管理界面入口，登录用户名为elastic，登录密码为您在配置时传入的密码"
  value       = format("http://%s:5601", alicloud_instance.ecs_instance_kibana.public_ip)
}

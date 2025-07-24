output "web_url" {
  description = "Web 访问地址"
  value       = format("http://%s:5000/home", alicloud_instance.ecs_instance.public_ip)
}

output "ecs_login_address" {
  description = "ECS登录地址"
  value = format("https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=%s&instanceId=%s",
    data.alicloud_regions.current_region_ds.regions[0].id,
  alicloud_instance.ecs_instance.id)
}

output "vpc_id" {
  description = "VPC ID"
  value       = alicloud_vpc.vpc.id
}

output "vswitch_id" {
  description = "VSwitch ID"
  value       = alicloud_vswitch.vswitch.id
}

output "security_group_id" {
  description = "安全组ID"
  value       = alicloud_security_group.security_group.id
}

output "ecs_instance_id" {
  description = "ECS实例ID"
  value       = alicloud_instance.ecs_instance.id
}

output "ecs_public_ip" {
  description = "ECS公网IP"
  value       = alicloud_instance.ecs_instance.public_ip
}

output "analyticdb_instance_id" {
  description = "AnalyticDB实例ID"
  value       = alicloud_gpdb_instance.analyticdb.id
}

output "analyticdb_connection_string" {
  description = "AnalyticDB连接字符串"
  value       = alicloud_gpdb_instance.analyticdb.connection_string
}

output "region_id" {
  description = "部署区域ID"
  value       = data.alicloud_regions.current_region_ds.regions[0].id
}

output "zone_id" {
  description = "部署可用区ID"
  value       = var.zone_id
} 
output "ecs_instances" {
  description = "查看创建的ECS实例列表"
  value       = format("https://ecs.console.aliyun.com/server/region/%s?instanceIds=%s,%s,%s,%s", var.region, alicloud_instance.ecs_instance_in_vpc_prd1.id, alicloud_instance.ecs_instance_in_vpc_prd2.id, alicloud_instance.ecs_instance_in_vpc_prd3.id, alicloud_instance.ecs_instance_in_vpc_sec.id)
}


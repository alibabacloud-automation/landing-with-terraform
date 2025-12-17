# ------------------------------------------------------------------------------
# 模块输出值 (Module Outputs)
#
# 本文件定义了模块执行成功后返回给调用方的值。
# 这些输出可以被其他 Terraform 配置引用，或在 apply 命令结束后显示给用户。
# ------------------------------------------------------------------------------

output "ecs_login_address" {
  description = "部署应用的ECS实例的登录地址。"
  value       = format("https://ecs-workbench.aliyun.com/?from=ecs&instanceType=ecs&regionId=%s&instanceId=%s&resourceGroupId=", local.region, alicloud_instance.ecs_instance.id)
}

output "vpc_id" {
  description = "已创建的VPC ID"
  value       = alicloud_vpc.vpc.id
}

output "vswitch_id" {
  description = "已创建的VSwitch ID"
  value       = alicloud_vswitch.ecs_vswitch.id
}
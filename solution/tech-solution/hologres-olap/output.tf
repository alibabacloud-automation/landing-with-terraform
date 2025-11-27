# ------------------------------------------------------------------------------
# 模块输出值
#
# 本文件定义了模块执行成功后返回给调用方的值。
# 这些输出可以被其他 Terraform 配置引用，或在 apply 命令结束后显示给用户。
# ------------------------------------------------------------------------------

# 输出 Hologram 实例 ID
output "hologram_instance_id" {
  value       = alicloud_hologram_instance.hologram.id
  description = "Hologram 实例 ID"
}

# 输出专有网络实例 ID
output "vpc_instance_id" {
  value       = alicloud_vpc.vpc.id
  description = "专有网络实例 ID"
}

# 输出交换机实例 ID
output "vswitch_instance_id" {
  value       = alicloud_vswitch.vswitch.id
  description = "交换机实例 ID"
}

# 输出JDBC连接地址
output "jdbcaddress" {
  value       = "rm-bp1z69dodhh85z9qa.mysql.rds.aliyuncs.com:3306"
  description = "JDBC连接地址"
}

# 输出数据库名称
output "data_base_name" {
  value       = "github_events_share"
  description = "数据库名称"
}

# 输出数据库用户名
output "data_base_user_name" {
  value       = "workshop"
  description = "数据库用户名"
}

# 输出数据库密码
output "data_base_password" {
  value       = "workshop#2017"
  description = "数据库密码"
}
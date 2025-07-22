output "database_name" {
  description = "The name of database."
  value       = alicloud_db_database.rds_database.name
}

output "database_user_name" {
  description = "The name of database user."
  value       = alicloud_rds_account.create_db_user.account_name
}

output "database_endpoint" {
  description = "The connection address of database."
  value       = alicloud_db_instance.rds_instance.connection_string
}

output "ecs_login_address" {
  description = "Ecs login address"
  value       = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&instanceId=${alicloud_instance.ecs_instance.id}"
}
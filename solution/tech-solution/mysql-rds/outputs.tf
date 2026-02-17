# ECS Instance Login Information
output "ecs_instance_user" {
  description = "Username and password for logging in to ECS instance"
  value       = "USERNAME: root ; PASSWORD: ${var.ecs_instance_password}"
  sensitive   = true
}

# WordPress URL
output "ecs_word_press_url" {
  description = "WordPress default address"
  value       = "http://${alicloud_instance.web_server.public_ip}"
}

# RDS Internal Connection Address
output "rds_internal_address" {
  description = "RDS internal network address"
  value       = alicloud_db_instance.database.connection_string
}

# RDS User Information for DTS
output "rds_user_dts" {
  description = "RDS username and password for connecting to DTS"
  value       = "USERNAME: ${var.db_user_name} PASSWORD: ${var.db_password}"
  sensitive   = true
}

# WordPress Database User for DTS
output "wp_user_for_dts" {
  description = "ECS-hosted database username and password for connecting to DTS"
  value       = "USERNAME: dtssync1 ; PASSWORD: P@ssw0rd"
  sensitive   = true
}

# WordPress Database User for SQL
output "wp_user_for_sql" {
  description = "ECS-hosted database username and password for executing SQL"
  value       = "USERNAME: wordpressuser ; PASSWORD: password"
  sensitive   = true
}
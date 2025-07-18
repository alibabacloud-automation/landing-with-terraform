# Outputs
output "mongodb_inner_connection_string" {
  description = "MongoDB内网连接地址"
  value       = "mongodb://root:${var.mongodb_password}@${alicloud_mongodb_instance.mongodb.replica_sets[0].connection_domain}:27017/${var.db_name}"
  sensitive   = true
}
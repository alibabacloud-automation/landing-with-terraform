output "vpc_id" {
  description = "VPC ID"
  value       = alicloud_vpc.vpc.id
}

output "vswitch_id" {
  description = "VSwitch ID"
  value       = alicloud_vswitch.vswitch.id
}

output "rds_instance_id" {
  description = "RDS Instance ID"
  value       = alicloud_db_instance.rds.id
}

output "redis_instance_id" {
  description = "Redis Instance ID"
  value       = alicloud_kvstore_instance.redis.id
}

output "dts_instance_id" {
  description = "DTS Instance ID"
  value       = alicloud_dts_synchronization_instance.dts.id
}

output "dts_job_id" {
  description = "DTS Job ID"
  value       = alicloud_dts_synchronization_job.job.id
}
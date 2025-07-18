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

output "nas_file_system_id" {
  description = "NAS文件系统ID"
  value       = alicloud_nas_file_system.nas_file_system.id
}

output "nas_mount_target_domain" {
  description = "NAS挂载点域名"
  value       = alicloud_nas_mount_target.nas_mount_target.mount_target_domain
}

output "pai_service_id" {
  description = "PAI-EAS服务ID"
  value       = alicloud_pai_service.pai_eas.id
}

output "service_name" {
  description = "PAI-EAS服务名称"
  value       = "qwen_demo_${random_string.random_string.result}"
}

output "service_status" {
  description = "PAI-EAS服务状态"
  value       = alicloud_pai_service.pai_eas.status
}

output "create_time" {
  description = "PAI-EAS服务创建时间"
  value       = alicloud_pai_service.pai_eas.create_time
}

output "region_id" {
  description = "部署区域ID"
  value       = data.alicloud_regions.current.regions.0.id
} 
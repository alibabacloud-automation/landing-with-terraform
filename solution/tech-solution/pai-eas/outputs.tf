output "vpc_id" {
  description = "VPC ID"
  value       = alicloud_vpc.vpc.id
}

output "vswitch_id" {
  description = "VSwitch ID"
  value       = alicloud_vswitch.vswitch.id
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = alicloud_nat_gateway.nat_gateway.id
}

output "eip_address" {
  description = "EIP地址"
  value       = alicloud_eip.eip.ip_address
}

output "security_group_id" {
  description = "安全组ID"
  value       = alicloud_security_group.security_group.id
}

output "nas_file_system_id" {
  description = "NAS文件系统ID"
  value       = alicloud_nas_file_system.nas.id
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
  value       = "sdwebui_${random_string.random_string.result}"
} 
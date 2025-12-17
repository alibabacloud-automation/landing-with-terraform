output "web_url" {
  description = "Web访问地址"
  value       = "http://${alicloud_alb_load_balancer.main.dns_name}"
}

output "vpc_id" {
  description = "VPC ID"
  value       = alicloud_vpc.main.id
}

output "vpc_cidr_block" {
  description = "VPC CIDR块"
  value       = alicloud_vpc.main.cidr_block
}

output "vswitch_ids" {
  description = "交换机ID列表"
  value = {
    web_01 = alicloud_vswitch.web_01.id
    web_02 = alicloud_vswitch.web_02.id
    db_01  = alicloud_vswitch.db_01.id
    pub_01 = alicloud_vswitch.pub_01.id
    pub_02 = alicloud_vswitch.pub_02.id
  }
}

output "security_group_id" {
  description = "安全组ID"
  value       = alicloud_security_group.main.id
}

output "polardb_cluster_id" {
  description = "PolarDB集群ID"
  value       = alicloud_polardb_cluster.main.id
}

output "polardb_connection_string" {
  description = "PolarDB连接地址"
  value       = alicloud_polardb_cluster.main.connection_string
  sensitive   = true
}

output "alb_id" {
  description = "应用负载均衡器ID"
  value       = alicloud_alb_load_balancer.main.id
}

output "alb_dns_name" {
  description = "应用负载均衡器DNS名称"
  value       = alicloud_alb_load_balancer.main.dns_name
}

output "sae_namespace_id" {
  description = "SAE命名空间ID"
  value       = alicloud_sae_namespace.main.id
}

output "sae_application_id" {
  description = "SAE应用ID"
  value       = alicloud_sae_application.main.id
}

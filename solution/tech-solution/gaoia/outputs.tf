output "nlb_dns_name" {
  description = "NLB的DNS名称"
  value       = alicloud_nlb_load_balancer.nlb_load_balancer.dns_name
}

output "accelerator_id" {
  description = "全球加速实例ID"
  value       = alicloud_ga_accelerator.accelerator.id
}

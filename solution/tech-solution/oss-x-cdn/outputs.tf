output "accelerate_domain_name" {
  description = "加速域名"
  value       = alicloud_cdn_domain_new.domain.domain_name
}

output "cname_domain_name" {
  description = "CNAME域名"
  value       = alicloud_cdn_domain_new.domain.cname
}

output "origin_server" {
  description = "源站"
  value       = "${alicloud_oss_bucket.oss_bucket.id}.${alicloud_oss_bucket.oss_bucket.extranet_endpoint}"
}

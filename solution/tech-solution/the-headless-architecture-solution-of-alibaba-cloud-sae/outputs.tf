output "web_url" {
  description = "示例网站地址/Sample website address"
  value       = "http://${alicloud_slb_load_balancer.slb_frontend.address}"
}

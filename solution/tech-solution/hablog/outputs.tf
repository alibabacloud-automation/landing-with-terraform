output "WebUrl" {
  description = <<EOT
    {
      "zh-cn": "Web 访问地址。",
      "en": "The Addresses of Web."
    }
    EOT
  value       = format("http://%s", alicloud_alb_load_balancer.alb.dns_name)
}
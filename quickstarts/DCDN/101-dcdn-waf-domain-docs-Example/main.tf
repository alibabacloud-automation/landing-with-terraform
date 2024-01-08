variable "domain_name" {
  default = "tf-example.com"
}

resource "alicloud_dcdn_domain" "example" {
  domain_name = var.domain_name
  scope       = "overseas"
  sources {
    content  = "1.1.1.1"
    port     = "80"
    priority = "20"
    type     = "ipaddr"
    weight   = "10"
  }
}

resource "alicloud_dcdn_waf_domain" "example" {
  domain_name   = alicloud_dcdn_domain.example.domain_name
  client_ip_tag = "X-Forwarded-For"
}
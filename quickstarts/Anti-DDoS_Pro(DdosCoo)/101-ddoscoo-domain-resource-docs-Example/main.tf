provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tf-example"
}
variable "domain" {
  default = "tf-example.alibaba.com"
}

resource "alicloud_ddoscoo_instance" "default" {
  name              = var.name
  bandwidth         = "30"
  base_bandwidth    = "30"
  service_bandwidth = "100"
  port_count        = "50"
  domain_count      = "50"
  period            = "1"
  product_type      = "ddoscoo"
}

resource "alicloud_ddoscoo_domain_resource" "default" {
  domain       = var.domain
  rs_type      = 0
  instance_ids = [alicloud_ddoscoo_instance.default.id]
  real_servers = ["177.167.32.11"]
  https_ext    = "{\"Http2\":1,\"Http2https\":0,\"Https2http\":0}"
  proxy_types {
    proxy_ports = [443]
    proxy_type  = "https"
  }
}
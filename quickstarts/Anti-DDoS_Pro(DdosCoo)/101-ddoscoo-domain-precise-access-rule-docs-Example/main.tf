provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "terraform"
}

variable "domain" {
  default = "terraform-example.alibaba.com"
}

data "alicloud_ddoscoo_instances" "default" {
}

resource "alicloud_ddoscoo_domain_resource" "default" {
  domain       = var.domain
  instance_ids = [data.alicloud_ddoscoo_instances.default.ids.0]
  proxy_types {
    proxy_ports = [443]
    proxy_type  = "https"
  }
  real_servers = ["177.167.32.11"]
  rs_type      = 0
}

resource "alicloud_ddoscoo_domain_precise_access_rule" "default" {
  condition {
    match_method = "contain"
    field        = "header"
    content      = "222"
    header_name  = "15"
  }
  action  = "accept"
  expires = "0"
  domain  = alicloud_ddoscoo_domain_resource.default.id
  name    = var.name
}
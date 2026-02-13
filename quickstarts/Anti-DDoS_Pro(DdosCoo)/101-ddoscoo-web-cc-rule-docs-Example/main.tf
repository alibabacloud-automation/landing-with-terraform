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

resource "alicloud_ddoscoo_web_cc_rule" "default" {
  rule_detail {
    action = "block"
    rate_limit {
      interval  = "11"
      threshold = "2"
      ttl       = "840"
      target    = "header"
      sub_key   = "33"
    }
    condition {
      match_method = "belong"
      field        = "ip"
      content      = "1.1.1.1"
    }
    condition {
      match_method = "contain"
      field        = "uri"
      content      = "/a"
    }
    condition {
      match_method = "contain"
      field        = "header"
      header_name  = "123"
      content      = "1234"
    }
    statistics {
      mode        = "distinct"
      field       = "header"
      header_name = "12"
    }
    status_code {
      enabled         = true
      code            = "100"
      use_ratio       = false
      count_threshold = "2"
      ratio_threshold = "5"
    }
  }
  name   = var.name
  domain = alicloud_ddoscoo_domain_resource.default.id
}
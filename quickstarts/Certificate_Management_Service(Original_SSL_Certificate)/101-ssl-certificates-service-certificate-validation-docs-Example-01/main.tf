variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_ssl_certificates_service_instance" "default" {
  product_type      = "cas"
  period            = 12
  pricing_cycle     = 2
  instance_name     = var.name
  domain            = "example.com"
  validation_method = "DNS"

  parameter {
    code  = "fullSpec"
    value = "ws.dv.f"
  }
  parameter {
    code  = "fullDomainCount"
    value = "1"
  }
}

resource "alicloud_ssl_certificates_service_certificate_apply" "default" {
  instance_id       = alicloud_ssl_certificates_service_instance.default.id
  domain            = alicloud_ssl_certificates_service_instance.default.domain
  validation_method = alicloud_ssl_certificates_service_instance.default.validation_method
}

resource "alicloud_alidns_record" "default" {
  for_each = {
    for v in alicloud_ssl_certificates_service_certificate_apply.default.domain_validation_list :
    v.domain => v
  }
  domain_name = each.value.root_domain
  rr          = each.value.validation_key
  type        = each.value.validation_type
  value       = each.value.validation_value
  ttl         = 600
}

resource "alicloud_ssl_certificates_service_certificate_validation" "default" {
  instance_id           = alicloud_ssl_certificates_service_instance.default.id
  validation_record_ids = [for r in alicloud_alidns_record.default : r.id]

  timeouts {
    create = "120m"
  }
}
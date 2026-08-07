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

output "domain_validation_list" {
  value = alicloud_ssl_certificates_service_certificate_apply.default.domain_validation_list
}
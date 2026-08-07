provider "alicloud" {
  region = "cn-hangzhou"
}

variable "certificate_id" {
  default = 12345678
}

resource "alicloud_ssl_certificates_service_instance_certificate" "default" {
  certificate_id = var.certificate_id
}

output "cert_identifier" {
  value = alicloud_ssl_certificates_service_instance_certificate.default.cert_identifier
}
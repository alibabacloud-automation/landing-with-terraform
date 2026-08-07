resource "alicloud_alb_listener" "default" {
  certificates {
    certificate_id = alicloud_ssl_certificates_service_certificate_validation.default.cert_identifier
  }
}
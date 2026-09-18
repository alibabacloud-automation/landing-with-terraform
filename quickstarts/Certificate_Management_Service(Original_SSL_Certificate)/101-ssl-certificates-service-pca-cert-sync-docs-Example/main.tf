provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_ssl_certificates_service_pca_certificate" "root" {
  organization      = "a"
  years             = "1"
  locality          = "a"
  organization_unit = "a"
  state             = "a"
  common_name       = "cbc.certqa.cn"
}

resource "alicloud_ssl_certificates_service_pca_certificate" "sub" {
  parent_identifier = alicloud_ssl_certificates_service_pca_certificate.root.id
  organization      = "a"
  years             = "1"
  locality          = "a"
  organization_unit = "a"
  state             = "a"
  common_name       = "cbc.certqa.cn"
  algorithm         = "RSA_2048"
  certificate_type  = "SUB_ROOT"
  enable_crl        = true
}

resource "alicloud_ssl_certificates_service_pca_cert" "default" {
  count             = 2
  days              = "1"
  parent_identifier = alicloud_ssl_certificates_service_pca_certificate.sub.id
  algorithm         = "RSA_2048"
  common_name       = "terraform-${count.index}"
  organization      = "terraform"
  state             = "Beijing"
  country_code      = "cn"
}

resource "alicloud_ssl_certificates_service_pca_cert_sync" "default" {
  ids = alicloud_ssl_certificates_service_pca_cert.default[*].id
}
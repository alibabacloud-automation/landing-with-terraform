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
  immediately       = "0"
  organization      = "terraform"
  years             = "1"
  upload_flag       = "0"
  locality          = "terraform"
  months            = "1"
  custom_identifier = "181"
  algorithm         = "RSA_2048"
  parent_identifier = alicloud_ssl_certificates_service_pca_certificate.sub.id
  san_value         = "somebody@example.com"
  enable_crl        = "1"
  organization_unit = "aliyun"
  state             = "Beijing"
  before_time       = "1767948807"
  days              = "1"
  san_type          = "1"
  after_time        = "1768035207"
  country_code      = "cn"
  common_name       = "exampleTerraform"
  alias_name        = "AliasName"
  status            = "ISSUE"
}
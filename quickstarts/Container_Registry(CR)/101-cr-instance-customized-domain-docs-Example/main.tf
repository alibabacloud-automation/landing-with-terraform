variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_ssl_certificates_service_certificates" "default" {
  keyword = "alicloud-provider.cn"
}

resource "alicloud_cr_ee_instance" "default" {
  payment_type   = "Subscription"
  period         = 1
  renew_period   = 1
  renewal_status = "AutoRenewal"
  instance_type  = "Advanced"
  instance_name  = var.name
}

resource "alicloud_cr_instance_customized_domain" "default" {
  instance_id    = alicloud_cr_ee_instance.default.id
  module_name    = "Registry"
  domain         = "alicloud-provider.cn"
  cert_id        = data.alicloud_ssl_certificates_service_certificates.default.certificates.0.id
  cert_region_id = "cn-hangzhou"
}
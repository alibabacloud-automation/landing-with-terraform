data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
  site_name           = "gositecdn.cn"
}

resource "alicloud_esa_client_ca_certificate" "default" {
  certificate         = "-----BEGIN CERTIFICATE-----\n****-----END CERTIFICATE-----"
  client_ca_cert_name = "example"
  site_id             = data.alicloud_esa_sites.default.sites.0.id
}
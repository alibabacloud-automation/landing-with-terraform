data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
  site_name           = "gositecdn.cn"
}

resource "alicloud_esa_client_certificate" "default" {
  site_id       = data.alicloud_esa_sites.default.sites.0.id
  pkey_type     = "RSA"
  validity_days = "365"
}
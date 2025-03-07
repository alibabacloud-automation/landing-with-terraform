data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
  site_name           = "gositecdn.cn"
}

resource "alicloud_esa_certificate" "default" {
  created_type = "free"
  domains      = "101.gositecdn.cn"
  site_id      = data.alicloud_esa_sites.default.sites.0.id
  type         = "lets_encrypt"
}
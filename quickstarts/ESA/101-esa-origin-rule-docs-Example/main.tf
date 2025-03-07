data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
}

resource "alicloud_esa_origin_rule" "default" {
  origin_sni        = "origin.example.com"
  site_id           = data.alicloud_esa_sites.default.sites.0.id
  origin_host       = "origin.example.com"
  dns_record        = "tf.example.com"
  site_version      = "0"
  rule_name         = "tf"
  origin_https_port = "443"
  origin_scheme     = "http"
  range             = "on"
  origin_http_port  = "8080"
  rule              = "(http.host eq \"video.example.com\")"
  rule_enable       = "on"
}
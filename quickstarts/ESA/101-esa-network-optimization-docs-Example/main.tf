data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
}

resource "alicloud_esa_site" "default" {
  site_name   = "gositecdn.cn"
  instance_id = data.alicloud_esa_sites.default.sites.0.instance_id
  coverage    = "overseas"
  access_type = "NS"
}

resource "alicloud_esa_network_optimization" "default" {
  site_version        = "0"
  site_id             = alicloud_esa_site.default.id
  rule_enable         = "on"
  websocket           = "off"
  rule                = "(http.host eq \"tf.example.com\")"
  grpc                = "off"
  http2_origin        = "off"
  smart_routing       = "off"
  upload_max_filesize = "100"
  rule_name           = "network_optimization"
}
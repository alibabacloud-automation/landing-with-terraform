data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
}

resource "alicloud_esa_site" "default" {
  site_name   = "imagetransform.tf.com"
  instance_id = data.alicloud_esa_sites.default.sites.0.instance_id
  coverage    = "domestic"
  access_type = "NS"
}

resource "alicloud_esa_image_transform" "default" {
  rule         = "http.host eq \"video.example.com\""
  site_version = "0"
  rule_name    = "rule_example"
  site_id      = alicloud_esa_site.default.id
  rule_enable  = "off"
  enable       = "off"
}
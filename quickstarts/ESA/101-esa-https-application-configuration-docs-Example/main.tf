data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
}

resource "alicloud_esa_site" "default" {
  site_name   = "httpsapplicationconfiguration.example.com"
  instance_id = data.alicloud_esa_sites.default.sites.0.instance_id
  coverage    = "domestic"
  access_type = "NS"
}

resource "alicloud_esa_https_application_configuration" "default" {
  hsts_max_age            = "31536000"
  alt_svc_clear           = "off"
  rule                    = "http.host eq \"video.example.com\""
  https_force             = "off"
  alt_svc_ma              = "86400"
  hsts                    = "off"
  rule_name               = "rule_example"
  rule_enable             = "off"
  site_id                 = alicloud_esa_site.default.id
  alt_svc_persist         = "off"
  hsts_preload            = "off"
  hsts_include_subdomains = "off"
  alt_svc                 = "off"
  https_force_code        = "301"
  site_version            = "0"
}
data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
}

resource "alicloud_esa_cache_rule" "default" {
  user_device_type            = "off"
  browser_cache_mode          = "no_cache"
  user_language               = "off"
  check_presence_header       = "headername"
  include_cookie              = "cookie_exapmle"
  edge_cache_mode             = "follow_origin"
  additional_cacheable_ports  = "2053"
  rule_name                   = "rule_example"
  edge_status_code_cache_ttl  = "300"
  browser_cache_ttl           = "300"
  query_string                = "example"
  user_geo                    = "off"
  sort_query_string_for_cache = "off"
  check_presence_cookie       = "cookiename"
  cache_reserve_eligibility   = "bypass_cache_reserve"
  query_string_mode           = "ignore_all"
  rule                        = "http.host eq \"video.example.com\""
  cache_deception_armor       = "off"
  site_id                     = data.alicloud_esa_sites.default.sites.0.id
  bypass_cache                = "cache_all"
  edge_cache_ttl              = "300"
  rule_enable                 = "off"
  site_version                = "0"
  include_header              = "example"
  serve_stale                 = "off"
}
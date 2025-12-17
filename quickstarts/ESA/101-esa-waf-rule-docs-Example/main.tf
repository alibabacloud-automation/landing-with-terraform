data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
}

resource "alicloud_esa_waf_ruleset" "default" {
  site_id      = data.alicloud_esa_sites.default.sites.0.site_id
  phase        = "http_custom"
  site_version = "0"
}

resource "alicloud_esa_waf_rule" "default" {
  ruleset_id = alicloud_esa_waf_ruleset.default.ruleset_id
  phase      = "http_custom"
  config {
    status     = "on"
    action     = "deny"
    expression = "(http.host in {\"123.example.top\"})"
    actions {
      response {
        id   = "0"
        code = "403"
      }

    }

    name = "111"
  }

  site_version = "0"
  site_id      = data.alicloud_esa_sites.default.sites.0.site_id
}
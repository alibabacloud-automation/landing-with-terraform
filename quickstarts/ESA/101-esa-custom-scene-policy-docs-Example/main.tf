variable "name" {
  default = "bcd58610.com"
}

data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
}

resource "alicloud_esa_site" "default" {
  site_name          = var.name
  instance_id        = data.alicloud_esa_sites.default.sites.0.instance_id
  coverage           = "overseas"
  access_type        = "NS"
  version_management = true
}

resource "alicloud_esa_custom_scene_policy" "default" {
  end_time                 = "2025-08-07T17:00:00Z"
  create_time              = "2025-07-07T17:00:00Z"
  site_ids                 = alicloud_esa_site.default.id
  template                 = "promotion"
  custom_scene_policy_name = "example-policy"
}
variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
}

resource "alicloud_esa_site" "default" {
  site_name   = "chenxin0116.site"
  instance_id = data.alicloud_esa_sites.default.sites.0.instance_id
  coverage    = "overseas"
  access_type = "NS"
}

resource "alicloud_esa_routine" "default" {
  description = "example-routine2"
  name        = "example-routine2"
}

resource "alicloud_esa_routine_route" "default" {
  route_enable = "on"
  rule         = "(http.host eq \"video.example1.com\")"
  sequence     = "1"
  routine_name = alicloud_esa_routine.default.name
  site_id      = alicloud_esa_site.default.id
  bypass       = "off"
  route_name   = "example_routine"
}
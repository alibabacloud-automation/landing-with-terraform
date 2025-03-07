data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
}

resource "alicloud_esa_site" "resource_Site_example" {
  site_name   = "terraform.site"
  instance_id = data.alicloud_esa_sites.default.sites.0.instance_id
  coverage    = "overseas"
  access_type = "NS"
}

resource "alicloud_esa_waiting_room" "default" {
  queuing_method     = "fifo"
  session_duration   = "5"
  total_active_users = "300"
  host_name_and_path {
    domain    = "sub_domain.com"
    path      = "/example"
    subdomain = "example_sub_domain.com."
  }
  host_name_and_path {
    domain    = "sub_domain.com"
    path      = "/example"
    subdomain = "example_sub_domain1.com."
  }
  host_name_and_path {
    path      = "/example"
    subdomain = "example_sub_domain2.com."
    domain    = "sub_domain.com"
  }

  waiting_room_type              = "default"
  new_users_per_minute           = "200"
  custom_page_html               = ""
  language                       = "zhcn"
  queuing_status_code            = "200"
  waiting_room_name              = "waitingroom_example"
  status                         = "off"
  site_id                        = alicloud_esa_site.resource_Site_example.id
  queue_all_enable               = "off"
  disable_session_renewal_enable = "off"
  description                    = "example"
  json_response_enable           = "off"
  cookie_name                    = "__aliwaitingroom_example"
}
data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
}

resource "alicloud_esa_site" "default" {
  site_name   = "terraform.site"
  instance_id = data.alicloud_esa_sites.default.sites.0.instance_id
  coverage    = "overseas"
  access_type = "NS"
}

resource "alicloud_esa_waiting_room" "default" {
  status                         = "off"
  site_id                        = alicloud_esa_site.default.id
  json_response_enable           = "off"
  description                    = "example"
  waiting_room_type              = "default"
  disable_session_renewal_enable = "off"
  cookie_name                    = "__aliwaitingroom_example"
  waiting_room_name              = "waitingroom_example"
  queue_all_enable               = "off"
  queuing_status_code            = "200"
  custom_page_html               = ""
  new_users_per_minute           = "200"
  session_duration               = "5"
  language                       = "zhcn"
  total_active_users             = "300"
  queuing_method                 = "fifo"
  host_name_and_path {
    domain    = "sub_domain.com"
    path      = "/example"
    subdomain = "example_sub_domain.com."
  }
}

resource "alicloud_esa_waiting_room_rule" "default" {
  rule            = "(http.host eq \"video.example.com\")"
  waiting_room_id = alicloud_esa_waiting_room.default.waiting_room_id
  rule_name       = "WaitingRoomRule_example1"
  status          = "off"
  site_id         = alicloud_esa_site.default.id
}
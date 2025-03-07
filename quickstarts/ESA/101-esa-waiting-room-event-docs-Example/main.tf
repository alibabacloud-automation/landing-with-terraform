data "alicloud_esa_sites" "default" {
  plan_subscribe_type = "enterpriseplan"
}

resource "alicloud_esa_site" "default" {
  site_name   = "chenxin0116.site"
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

resource "alicloud_esa_waiting_room_event" "default" {
  waiting_room_id                = alicloud_esa_waiting_room.default.waiting_room_id
  end_time                       = "1719863200"
  waiting_room_event_name        = "WaitingRoomEvent_example"
  pre_queue_start_time           = ""
  random_pre_queue_enable        = "off"
  json_response_enable           = "off"
  site_id                        = alicloud_esa_site.default.id
  pre_queue_enable               = "off"
  description                    = "example"
  new_users_per_minute           = "200"
  queuing_status_code            = "200"
  custom_page_html               = ""
  language                       = "zhcn"
  total_active_users             = "300"
  waiting_room_type              = "default"
  start_time                     = "1719763200"
  status                         = "off"
  disable_session_renewal_enable = "off"
  queuing_method                 = "fifo"
  session_duration               = "5"
}
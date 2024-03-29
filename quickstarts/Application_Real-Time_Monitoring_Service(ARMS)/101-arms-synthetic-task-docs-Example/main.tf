variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_resource_manager_resource_groups" "default" {}

resource "alicloud_arms_synthetic_task" "default" {
  monitors {
    city_code     = "1200101"
    operator_code = "246"
    client_type   = "4"
  }
  synthetic_task_name = var.name
  custom_period {
    end_hour   = "12"
    start_hour = "11"
  }
  available_assertions {
    type     = "IcmpPackLoss"
    operator = "neq"
    expect   = "200"
    target   = "example"
  }
  available_assertions {
    type     = "IcmpPackAvgLatency"
    operator = "lte"
    expect   = "1000"
  }
  available_assertions {
    type     = "IcmpPackMaxLatency"
    operator = "lte"
    expect   = "10000"
  }
  tags = {
    Created = "TF"
    For     = "example"
  }
  status = "RUNNING"
  monitor_conf {
    net_tcp {
      tracert_timeout = "1050"
      target_url      = "www.aliyun.com"
      connect_times   = "6"
      interval        = "300"
      timeout         = "3000"
      tracert_num_max = "2"
    }
    net_dns {
      query_method       = "1"
      timeout            = "5050"
      target_url         = "www.aliyun.com"
      dns_server_ip_type = "1"
      ns_server          = "61.128.114.167"
    }
    api_http {
      timeout    = "10050"
      target_url = "https://www.aliyun.com"
      method     = "POST"
      request_headers = {
        key1 = "value1"
      }
      request_body {
        content = "example2"
        type    = "text/html"
      }
      connect_timeout = "6000"
    }
    website {
      slow_element_threshold   = "5005"
      verify_string_blacklist  = "Failed"
      element_blacklist        = "a.jpg"
      disable_compression      = "1"
      ignore_certificate_error = "0"
      monitor_timeout          = "20000"
      redirection              = "0"
      dns_hijack_whitelist     = "www.aliyun.com:203.0.3.55"
      page_tamper              = "www.aliyun.com:|/cc/bb/a.gif"
      flow_hijack_jump_times   = "10"
      custom_header            = "1"
      disable_cache            = "1"
      verify_string_whitelist  = "Senyuan"
      target_url               = "http://www.aliyun.com"
      automatic_scrolling      = "1"
      wait_completion_time     = "5005"
      flow_hijack_logo         = "senyuan1"
      custom_header_content = {
        key1 = "value1"
      }
      filter_invalid_ip = "0"
    }
    file_download {
      white_list                             = "www.aliyun.com:203.0.3.55"
      monitor_timeout                        = "1050"
      ignore_certificate_untrustworthy_error = "0"
      redirection                            = "0"
      ignore_certificate_canceled_error      = "0"
      ignore_certificate_auth_error          = "0"
      ignore_certificate_out_of_date_error   = "0"
      ignore_certificate_using_error         = "0"
      connection_timeout                     = "6090"
      ignore_invalid_host_error              = "0"
      verify_way                             = "0"
      custom_header_content = {
        key1 = "value1"
      }
      target_url                      = "https://www.aliyun.com"
      download_kernel                 = "0"
      quick_protocol                  = "2"
      ignore_certificate_status_error = "1"
      transmission_size               = "128"
      validate_keywords               = "senyuan1"
    }
    stream {
      stream_monitor_timeout = "10"
      stream_address_type    = "0"
      player_type            = "2"
      custom_header_content = {
        key1 = "value1"
      }
      white_list  = "www.aliyun.com:203.0.3.55"
      target_url  = "https://acd-assets.alicdn.com:443/2021productweek/week1_s.mp4"
      stream_type = "1"
    }
    net_icmp {
      target_url      = "www.aliyun.com"
      interval        = "200"
      package_num     = "36"
      package_size    = "512"
      timeout         = "1000"
      tracert_enable  = "true"
      tracert_num_max = "1"
      tracert_timeout = "1200"
    }
  }
  task_type        = "1"
  frequency        = "1h"
  monitor_category = "1"
  common_setting {
    xtrace_region = "cn-beijing"
    custom_host {
      hosts {
        domain = "www.a.aliyun.com"
        ips = [
          "153.3.238.102"
        ]
        ip_type = "0"
      }
      hosts {
        domain = "www.shifen.com"
        ips = [
          "153.3.238.110",
          "114.114.114.114",
          "127.0.0.1"
        ]
        ip_type = "1"
      }
      hosts {
        domain = "www.aliyun.com"
        ips = [
          "153.3.238.110",
          "180.101.50.242",
          "180.101.50.188"
        ]
        ip_type = "0"
      }
      select_type = "1"
    }
    monitor_samples   = "1"
    ip_type           = "1"
    is_open_trace     = "true"
    trace_client_type = "1"
  }
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.ids.0
}
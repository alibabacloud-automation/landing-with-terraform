variable "name" {
  default = "terraform-example"
}

resource "alicloud_cms_site_monitor" "basic" {
  address   = "https://www.alibabacloud.com"
  task_name = var.name
  task_type = "HTTP"
  interval  = 5
  isp_cities {
    isp  = "232"
    city = "641"
    type = "IDC"
  }
  option_json {
    response_content     = "example"
    expect_value         = "example"
    port                 = 81
    is_base_encode       = true
    ping_num             = 5
    match_rule           = 1
    failure_rate         = "0.3"
    request_content      = "example"
    attempts             = 4
    request_format       = "hex"
    password             = "YourPassword123!"
    diagnosis_ping       = true
    response_format      = "hex"
    cookie               = "key2=value2"
    ping_port            = 443
    user_name            = "example"
    dns_match_rule       = "DNS_IN"
    timeout              = 3000
    dns_server           = "223.6.6.6"
    diagnosis_mtr        = true
    header               = "key2:value2"
    min_tls_version      = "1.1"
    ping_type            = "udp"
    dns_type             = "NS"
    dns_hijack_whitelist = "DnsHijackWhitelist"
    http_method          = "post"
    assertions {
      operator = "lessThan"
      target   = 300
      type     = "response_time"
    }
  }
}
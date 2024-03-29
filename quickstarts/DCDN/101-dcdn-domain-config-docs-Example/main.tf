variable "domain_name" {
  default = "alibaba-example.com"
}

resource "alicloud_dcdn_domain" "example" {
  domain_name = var.domain_name
  scope       = "overseas"
  status      = "online"
  sources {
    content  = "1.1.1.1"
    type     = "ipaddr"
    priority = 20
    port     = 80
    weight   = 10
  }
}

resource "alicloud_dcdn_domain_config" "ip_allow_list_set" {
  domain_name   = alicloud_dcdn_domain.example.domain_name
  function_name = "ip_allow_list_set"
  function_args {
    arg_name  = "ip_list"
    arg_value = "192.168.0.1"
  }
}

resource "alicloud_dcdn_domain_config" "referer_white_list_set" {
  domain_name   = alicloud_dcdn_domain.example.domain_name
  function_name = "referer_white_list_set"
  function_args {
    arg_name  = "refer_domain_allow_list"
    arg_value = "110.110.110.110"
  }
}

resource "alicloud_dcdn_domain_config" "filetype_based_ttl_set" {
  domain_name   = alicloud_dcdn_domain.example.domain_name
  function_name = "filetype_based_ttl_set"
  function_args {
    arg_name  = "ttl"
    arg_value = "300"
  }
  function_args {
    arg_name  = "file_type"
    arg_value = "jpg"
  }
  function_args {
    arg_name  = "weight"
    arg_value = "1"
  }
}
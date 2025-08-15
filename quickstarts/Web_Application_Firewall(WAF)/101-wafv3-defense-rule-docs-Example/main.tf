variable "name" {
  default = "tfaccwafv310619"
}

variable "region_id" {
  default = "cn-hangzhou"
}

data "alicloud_wafv3_instances" "default" {
}

resource "alicloud_wafv3_domain" "default" {
  instance_id = data.alicloud_wafv3_instances.default.ids.0
  listen {
    protection_resource = "share"
    http_ports = [
      "81",
      "82",
      "83"
    ]
    https_ports = [

    ]
    xff_header_mode = "2"
    xff_headers = [
      "examplea",
      "exampleb",
      "examplec"
    ]
    custom_ciphers = [

    ]
    ipv6_enabled = "true"
  }

  redirect {
    keepalive_timeout = "15"
    backends = [
      "1.1.1.1",
      "3.3.3.3",
      "2.2.2.2"
    ]
    write_timeout      = "5"
    keepalive_requests = "1000"
    request_headers {
      key   = "examplekey1"
      value = "exampleValue1"
    }
    request_headers {
      key   = "key1"
      value = "value1"
    }
    request_headers {
      key   = "key22"
      value = "value22"
    }

    loadbalance        = "iphash"
    focus_http_backend = "false"
    sni_enabled        = "false"
    connect_timeout    = "5"
    read_timeout       = "5"
    keepalive          = "true"
    retry              = "true"
  }

  domain      = "zcexample_250746.wafqax.top"
  access_type = "share"
}


resource "alicloud_wafv3_defense_rule" "default" {
  defense_origin = "custom"
  config {
    account_identifiers {
      priority    = "2"
      decode_type = "jwt"
      key         = "Query-Arg"
      sub_key     = "adb"
      position    = "jwt"
    }
  }

  instance_id   = data.alicloud_wafv3_instances.default.ids.0
  defense_type  = "resource"
  defense_scene = "account_identifier"
  rule_status   = "1"
  resource      = alicloud_wafv3_domain.default.domain_id
}
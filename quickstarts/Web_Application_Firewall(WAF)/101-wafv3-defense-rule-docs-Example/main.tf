provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tfexample"
}

variable "region_id" {
  default = "cn-hangzhou"
}

variable "domain" {
  default = "example.wafqax.top"
}

data "alicloud_wafv3_instances" "default" {
}

resource "alicloud_wafv3_domain" "defaultICMRhk" {
  redirect {
    loadbalance     = "iphash"
    backends        = ["39.98.217.197"]
    connect_timeout = 5
    read_timeout    = 120
    write_timeout   = 120
  }
  domain      = "example.wafqax.top"
  access_type = "share"
  instance_id = data.alicloud_wafv3_instances.default.ids.0
  listen {
    http_ports = ["80"]
  }
}

resource "alicloud_wafv3_defense_rule" "default" {
  defense_type   = "resource"
  defense_scene  = "account_identifier"
  rule_status    = "1"
  resource       = alicloud_wafv3_domain.defaultICMRhk.domain_id
  defense_origin = "custom"
  config {
    account_identifiers {
      position    = "jwt"
      priority    = "2"
      decode_type = "jwt"
      key         = "Query-Arg"
      sub_key     = "adb"
    }

  }
  instance_id = data.alicloud_wafv3_instances.default.ids.0
}
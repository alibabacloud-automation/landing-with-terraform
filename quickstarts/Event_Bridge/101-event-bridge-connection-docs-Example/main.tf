provider "alicloud" {
  region = var.region
}

variable "region" {
  default = "cn-chengdu"
}

variable "name" {
  default = "terraform-example"
}

data "alicloud_zones" "default" {
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_zones.default.zones[0].id
  vswitch_name = var.name
}

resource "alicloud_security_group" "default" {
  name   = var.name
  vpc_id = alicloud_vswitch.default.vpc_id
}

resource "alicloud_event_bridge_connection" "default" {
  connection_name = var.name
  description     = "test-connection-basic-pre"
  network_parameters {
    network_type      = "PublicNetwork"
    vpc_id            = alicloud_vpc.default.id
    vswitche_id       = alicloud_vswitch.default.id
    security_group_id = alicloud_security_group.default.id
  }
  auth_parameters {
    authorization_type = "BASIC_AUTH"
    api_key_auth_parameters {
      api_key_name  = "Token"
      api_key_value = "Token-value"
    }
    basic_auth_parameters {
      username = "admin"
      password = "admin"
    }
    oauth_parameters {
      authorization_endpoint = "http://127.0.0.1:8080"
      http_method            = "POST"
      client_parameters {
        client_id     = "ClientId"
        client_secret = "ClientSecret"
      }
      oauth_http_parameters {
        header_parameters {
          key             = "name"
          value           = "name"
          is_value_secret = "true"
        }
        body_parameters {
          key             = "name"
          value           = "name"
          is_value_secret = "true"
        }
        query_string_parameters {
          key             = "name"
          value           = "name"
          is_value_secret = "true"
        }
      }
    }
  }
}
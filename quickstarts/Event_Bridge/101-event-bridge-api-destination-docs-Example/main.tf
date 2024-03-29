provider "alicloud" {
  region = var.region
}

variable "region" {
  default = "cn-chengdu"
}

variable "name" {
  default = "terraform-example"
}

resource "alicloud_event_bridge_connection" "default" {
  connection_name = var.name
  network_parameters {
    network_type = "PublicNetwork"
  }
}

resource "alicloud_event_bridge_api_destination" "default" {
  connection_name      = alicloud_event_bridge_connection.default.connection_name
  api_destination_name = var.name
  description          = "test-api-destination-connection"
  http_api_parameters {
    endpoint = "http://127.0.0.1:8001"
    method   = "POST"
  }
}
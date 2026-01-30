variable "name" {
  default = "terraform-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_event_bridge_event_bus" "default" {
  event_bus_name = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_event_bridge_event_source_v2" "default" {
  event_bus_name         = alicloud_event_bridge_event_bus.default.event_bus_name
  event_source_name      = "${var.name}-${random_integer.default.result}"
  description            = var.name
  linked_external_source = true
  source_http_event_parameters {
    type            = "HTTP"
    security_config = "referer"
    method          = ["GET", "POST", "DELETE"]
    referer         = ["www.aliyun.com", "www.alicloud.com", "www.taobao.com"]
  }
}
variable "name" {
  default = "terraform-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_mns_queue" "default" {
  name = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_event_bridge_event_bus" "default" {
  event_bus_name = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_event_bridge_event_source" "default" {
  event_bus_name         = alicloud_event_bridge_event_bus.default.event_bus_name
  event_source_name      = "${var.name}-${random_integer.default.result}"
  description            = var.name
  linked_external_source = true
  external_source_type   = "MNS"
  external_source_config = {
    QueueName = alicloud_mns_queue.default.name
  }
}
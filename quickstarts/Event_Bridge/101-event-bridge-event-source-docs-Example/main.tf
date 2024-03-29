variable "name" {
  default = "tf-example"
}
resource "alicloud_event_bridge_event_bus" "example" {
  event_bus_name = var.name
}
resource "alicloud_mns_queue" "example" {
  name = var.name
}
resource "alicloud_event_bridge_event_source" "example" {
  event_bus_name         = alicloud_event_bridge_event_bus.example.event_bus_name
  event_source_name      = var.name
  description            = var.name
  linked_external_source = true
  external_source_type   = "MNS"
  external_source_config = {
    QueueName = alicloud_mns_queue.example.name
  }
}
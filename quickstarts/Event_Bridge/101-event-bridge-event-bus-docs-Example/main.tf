variable "name" {
  default = "tf-example"
}
resource "alicloud_event_bridge_event_bus" "example" {
  event_bus_name = var.name
}
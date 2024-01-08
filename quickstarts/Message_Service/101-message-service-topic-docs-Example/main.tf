variable "name" {
  default = "tf-example"
}
resource "alicloud_message_service_topic" "default" {
  topic_name       = var.name
  max_message_size = 12357
  logging_enabled  = true
}
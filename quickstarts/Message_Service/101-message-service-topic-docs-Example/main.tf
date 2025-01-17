variable "name" {
  default = "terraform-example"
}

resource "alicloud_message_service_topic" "default" {
  topic_name       = var.name
  max_message_size = 16888
  enable_logging   = true
}
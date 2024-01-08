variable "name" {
  default = "tf-example"
}
resource "alicloud_message_service_queue" "queue" {
  queue_name               = var.name
  delay_seconds            = 60478
  maximum_message_size     = 12357
  message_retention_period = 256000
  visibility_timeout       = 30
  polling_wait_seconds     = 3
  logging_enabled          = true
}
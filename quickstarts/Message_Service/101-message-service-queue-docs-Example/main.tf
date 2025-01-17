variable "name" {
  default = "terraform-example"
}

resource "alicloud_message_service_queue" "default" {
  queue_name               = var.name
  delay_seconds            = "2"
  polling_wait_seconds     = "2"
  message_retention_period = "566"
  maximum_message_size     = "1126"
  visibility_timeout       = "30"
}
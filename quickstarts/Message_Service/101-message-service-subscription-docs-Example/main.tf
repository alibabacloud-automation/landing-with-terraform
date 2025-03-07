variable "name" {
  default = "terraform-example"
}

resource "alicloud_message_service_topic" "default" {
  topic_name       = var.name
  max_message_size = 16888
  enable_logging   = true
}

resource "alicloud_message_service_subscription" "default" {
  topic_name            = alicloud_message_service_topic.default.topic_name
  subscription_name     = var.name
  endpoint              = "http://example.com"
  push_type             = "http"
  filter_tag            = var.name
  notify_content_format = "XML"
  notify_strategy       = "BACKOFF_RETRY"
}
variable "name" {
  default = "tf-example"
}
resource "alicloud_message_service_topic" "default" {
  topic_name       = var.name
  max_message_size = 12357
  logging_enabled  = true
}

resource "alicloud_message_service_subscription" "default" {
  topic_name            = alicloud_message_service_topic.default.topic_name
  subscription_name     = var.name
  endpoint              = "http://example.com"
  push_type             = "http"
  filter_tag            = "tf-example"
  notify_content_format = "XML"
  notify_strategy       = "BACKOFF_RETRY"
}
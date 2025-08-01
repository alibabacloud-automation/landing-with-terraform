variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "queue_name" {
  default = "tf-exampe-topic2queue"
}

variable "rule_name" {
  default = "tf-exampe-topic-1"
}

variable "topic_name" {
  default = "tf-exampe-topic2queue"
}

resource "alicloud_message_service_topic" "CreateTopic" {
  max_message_size = "65536"
  topic_name       = var.topic_name
  logging_enabled  = false
}

resource "alicloud_message_service_queue" "CreateQueue" {
  delay_seconds            = "2"
  polling_wait_seconds     = "2"
  message_retention_period = "566"
  maximum_message_size     = "1123"
  visibility_timeout       = "30"
  queue_name               = var.queue_name
  logging_enabled          = false
}

resource "alicloud_message_service_subscription" "CreateSub" {
  push_type             = "queue"
  notify_strategy       = "BACKOFF_RETRY"
  notify_content_format = "SIMPLIFIED"
  subscription_name     = "RDK-example-sub"
  filter_tag            = "important"
  topic_name            = alicloud_message_service_topic.CreateTopic.topic_name
  endpoint              = format("acs:mns:cn-hangzhou:1511928242963727:/queues/%s", alicloud_message_service_queue.CreateQueue.id)
}

resource "alicloud_message_service_event_rule" "default" {
  event_types = [
    "ObjectCreated:PutObject"
  ]
  match_rules = [
    [
      {
        suffix      = ""
        match_state = "true"
        name        = "acs:oss:cn-hangzhou:1511928242963727:accccx"
        prefix      = ""
      }
    ]
  ]
  endpoint {
    endpoint_value = alicloud_message_service_subscription.CreateSub.topic_name
    endpoint_type  = "topic"
  }

  rule_name = var.rule_name
}
provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "terraform-example"
}

resource "alicloud_message_service_queue" "source" {
  queue_name = "${var.name}-source"
}

resource "alicloud_message_service_queue" "sink" {
  queue_name = "${var.name}-sink"
}

resource "alicloud_event_bridge_event_streaming" "default" {
  event_streaming_name = var.name
  description          = "terraform-example-event-streaming"
  filter_pattern       = "{}"
  source = jsonencode({
    SourceMNSParameters = {
      RegionId       = "cn-hangzhou"
      QueueName      = alicloud_message_service_queue.source.queue_name
      IsBase64Decode = true
    }
  })
  sink = jsonencode({
    SinkMNSParameters = {
      QueueName = {
        Value = alicloud_message_service_queue.sink.queue_name
        Form  = "CONSTANT"
      }
      Body = {
        Value = "$.data"
        Form  = "JSONPATH"
      }
      IsBase64Encode = {
        Value = "true"
        Form  = "CONSTANT"
      }
    }
  })
}
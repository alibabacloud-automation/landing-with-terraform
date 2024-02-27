variable "name" {
  default = "onsInstanceName"
}

variable "topic" {
  default = "onsTopicName"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}


resource "alicloud_ons_instance" "default" {
  name   = "${var.name}-${random_integer.default.result}"
  remark = "default_ons_instance_remark"
}

resource "alicloud_ons_topic" "default" {
  topic_name   = var.topic
  instance_id  = alicloud_ons_instance.default.id
  message_type = 0
  remark       = "dafault_ons_topic_remark"
}
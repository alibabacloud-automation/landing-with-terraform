variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_cloud_control_resource" "mq_instance" {
  desire_attributes = jsonencode({ "InstanceName" : "terraform-example-ons-instance" })
  product           = "Ons"
  resource_code     = "Instance"
}

resource "alicloud_cloud_control_resource" "default" {
  product           = "Ons"
  resource_code     = "Instance::Topic"
  resource_id       = alicloud_cloud_control_resource.mq_instance.resource_id
  desire_attributes = jsonencode({ "InstanceId" : "${alicloud_cloud_control_resource.mq_instance.resource_id}", "TopicName" : "terraform-example-ons-topic", "MessageType" : "1" })
}
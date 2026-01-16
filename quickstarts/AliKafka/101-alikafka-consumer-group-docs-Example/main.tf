variable "name" {
  default = "terraform-example"
}

data "alicloud_alikafka_instances" "default" {
}

resource "alicloud_alikafka_consumer_group" "default" {
  instance_id = data.alicloud_alikafka_instances.default.instances.0.id
  consumer_id = var.name
}
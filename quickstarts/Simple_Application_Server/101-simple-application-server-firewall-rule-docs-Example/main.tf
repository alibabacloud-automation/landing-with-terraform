provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tf_example"
}

data "alicloud_simple_application_server_images" "default" {}
data "alicloud_simple_application_server_plans" "default" {}

resource "alicloud_simple_application_server_instance" "default" {
  payment_type   = "Subscription"
  plan_id        = data.alicloud_simple_application_server_plans.default.plans.0.id
  instance_name  = var.name
  image_id       = data.alicloud_simple_application_server_images.default.images.0.id
  period         = 1
  data_disk_size = 100
}

resource "alicloud_simple_application_server_firewall_rule" "default" {
  instance_id   = alicloud_simple_application_server_instance.default.id
  rule_protocol = "Tcp"
  port          = "9999"
  remark        = var.name
}
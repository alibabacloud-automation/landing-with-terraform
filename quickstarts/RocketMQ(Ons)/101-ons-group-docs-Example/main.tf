variable "name" {
  default = "GID-tf-example"
}

variable "group_name" {
  default = "GID-tf-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_ons_instance" "default" {
  name = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_ons_group" "default" {
  group_name  = var.group_name
  instance_id = alicloud_ons_instance.default.id
  remark      = "dafault_ons_group_remark"
}
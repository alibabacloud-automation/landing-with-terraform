variable "name" {
  default = "tf-example"
}

resource "alicloud_resource_manager_resource_group" "default" {
  display_name        = var.name
  resource_group_name = var.name
}

resource "alicloud_vpc" "default" {
  vpc_name   = "${var.name}2"
  cidr_block = "10.0.0.0/8"
}


resource "alicloud_vpc_ipv4_gateway" "default" {
  ipv4_gateway_name        = var.name
  ipv4_gateway_description = var.name
  resource_group_id        = alicloud_resource_manager_resource_group.default.id
  vpc_id                   = alicloud_vpc.default.id
}
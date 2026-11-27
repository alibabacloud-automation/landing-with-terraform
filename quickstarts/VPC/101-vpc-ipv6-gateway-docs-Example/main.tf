terraform {
  required_providers {
    alicloud = {
      source = "aliyun/alicloud"
    }
  }
}

variable "name" {
  default = "terraform-example"
}

resource "alicloud_vpc" "defaultVpc" {
  description = "terraform-example"
  enable_ipv6 = true
}

resource "alicloud_resource_manager_resource_group" "defaultRg" {
  display_name        = "terraform-example-ipv6gateway503"
  resource_group_name = "${var.name}1"
}

resource "alicloud_resource_manager_resource_group" "changeRg" {
  display_name        = "terraform-example-ipv6gateway311"
  resource_group_name = "${var.name}2"
}


resource "alicloud_vpc_ipv6_gateway" "default" {
  description       = "terraform-example"
  ipv6_gateway_name = var.name
  vpc_id            = alicloud_vpc.defaultVpc.id
  resource_group_id = alicloud_resource_manager_resource_group.defaultRg.id
}
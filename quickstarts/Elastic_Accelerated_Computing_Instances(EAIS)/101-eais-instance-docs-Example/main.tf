variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

locals {
  zone_id = "cn-hangzhou-h"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "192.168.192.0/24"
  zone_id      = local.zone_id
}

resource "alicloud_security_group" "default" {
  name   = var.name
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_eais_instance" "default" {
  instance_type     = "eais.ei-a6.2xlarge"
  vswitch_id        = alicloud_vswitch.default.id
  security_group_id = alicloud_security_group.default.id
  instance_name     = var.name
}
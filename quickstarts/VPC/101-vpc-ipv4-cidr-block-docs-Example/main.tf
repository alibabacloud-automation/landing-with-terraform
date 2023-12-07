variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_vpc" "defaultvpc" {
  description = var.name
}

resource "alicloud_vpc_ipv4_cidr_block" "default" {
  secondary_cidr_block = "192.168.0.0/16"
  vpc_id               = alicloud_vpc.defaultvpc.id
}

variable "name" {
  default = "terraform_example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_vpc" "vpc_create" {
  is_default  = false
  description = "example vpc"
  cidr_block  = "192.168.0.0/16"
  vpc_name    = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_dms_enterprise_workspace" "default" {
  description    = var.name
  workspace_name = "${var.name}-${random_integer.default.result}"
  vpc_id         = alicloud_vpc.vpc_create.id
}
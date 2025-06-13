variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_esa_routine" "default" {
  description = var.name
  name        = var.name
}
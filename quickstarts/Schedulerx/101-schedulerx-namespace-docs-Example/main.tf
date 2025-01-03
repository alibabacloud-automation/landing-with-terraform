variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_schedulerx_namespace" "default" {
  namespace_name = var.name
  description    = var.name
}
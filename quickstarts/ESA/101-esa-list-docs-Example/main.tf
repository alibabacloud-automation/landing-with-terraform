provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "terraform-example"
}

resource "alicloud_esa_list" "default" {
  description = "resource example ip list"
  kind        = "ip"
  items = [
    "10.1.1.1",
    "10.1.1.2",
    "10.1.1.3"
  ]
  name = "resource_example_ip_list"
}
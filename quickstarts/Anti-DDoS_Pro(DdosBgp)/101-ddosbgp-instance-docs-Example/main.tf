provider "alicloud" {
  region = "cn-beijing"
}

variable "name" {
  default = "tf-example"
}

resource "alicloud_ddosbgp_instance" "instance" {
  name             = var.name
  base_bandwidth   = 20
  bandwidth        = -1
  ip_count         = 100
  ip_type          = "IPv4"
  normal_bandwidth = 100
  type             = "Enterprise"
}
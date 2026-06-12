variable "name" {
  default = "terraform-example"
}


resource "alicloud_vpc" "default" {
  description = "example description"
  cidr_block  = "10.0.0.0/8"
  vpc_name    = var.name
  enable_ipv6 = true
}
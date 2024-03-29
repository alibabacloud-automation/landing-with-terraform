variable "name" {
  default = "terraform-example"
}

resource "alicloud_ens_security_group" "default" {
  description         = var.name
  security_group_name = var.name
}
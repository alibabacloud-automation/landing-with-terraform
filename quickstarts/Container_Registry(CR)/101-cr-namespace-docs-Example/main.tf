variable "name" {
  default = "terraform-example"
}

resource "random_integer" "default" {
  min = 10000000
  max = 99999999
}

resource "alicloud_cr_namespace" "example" {
  name               = "${var.name}-${random_integer.default.result}"
  auto_create        = false
  default_visibility = "PUBLIC"
}
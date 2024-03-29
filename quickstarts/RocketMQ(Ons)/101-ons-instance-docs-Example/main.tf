variable "name" {
  default = "tf-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_ons_instance" "example" {
  instance_name = "${var.name}-${random_integer.default.result}"
  remark        = var.name
}
variable "name" {
  default = "tf_example"
}

resource "alicloud_api_gateway_backend" "default" {
  backend_name = var.name
  description  = var.name
  backend_type = "HTTP"
}
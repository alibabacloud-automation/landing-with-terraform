provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tf-example"
}
resource "alicloud_ddoscoo_instance" "default" {
  name              = var.name
  bandwidth         = "30"
  base_bandwidth    = "30"
  service_bandwidth = "100"
  port_count        = "50"
  domain_count      = "50"
  period            = "1"
  product_type      = "ddoscoo"
}

resource "alicloud_ddoscoo_port" "default" {
  instance_id       = alicloud_ddoscoo_instance.default.id
  frontend_port     = "7001"
  backend_port      = "7002"
  frontend_protocol = "tcp"
  real_servers      = ["1.1.1.1", "2.2.2.2"]
}
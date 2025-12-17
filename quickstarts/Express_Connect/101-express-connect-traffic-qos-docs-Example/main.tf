variable "name" {
  default = "terraform-example"
}

resource "alicloud_express_connect_traffic_qos" "createQos" {
  qos_name        = var.name
  qos_description = var.name
}
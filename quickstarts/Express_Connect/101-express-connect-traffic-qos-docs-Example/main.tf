variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-shanghai"
}


data "alicloud_express_connect_physical_connections" "default" {
  name_regex = "preserved-NODELETING"
}

resource "alicloud_express_connect_traffic_qos" "createQos" {
  qos_name        = var.name
  qos_description = "terraform-example"
}
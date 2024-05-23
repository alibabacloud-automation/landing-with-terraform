variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "ap-southeast-1"
}

resource "alicloud_vpn_customer_gateway" "default" {
  description           = var.name
  ip_address            = "4.3.2.10"
  asn                   = "1219002"
  customer_gateway_name = var.name
}
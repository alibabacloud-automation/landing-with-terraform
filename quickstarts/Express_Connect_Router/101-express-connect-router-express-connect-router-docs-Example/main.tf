variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_express_connect_router_express_connect_router" "defaultM9YxGW" {
  alibaba_side_asn = "65533"
}
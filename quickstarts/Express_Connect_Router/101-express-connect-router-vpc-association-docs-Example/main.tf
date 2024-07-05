variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_vpc" "default8qAtD6" {
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_express_connect_router_express_connect_router" "defaultM9YxGW" {
  alibaba_side_asn = "65533"
}

data "alicloud_account" "current" {
}

resource "alicloud_express_connect_router_vpc_association" "default" {
  ecr_id = alicloud_express_connect_router_express_connect_router.defaultM9YxGW.id
  allowed_prefixes = [
    "172.16.4.0/24",
    "172.16.3.0/24",
    "172.16.2.0/24",
    "172.16.1.0/24"
  ]
  vpc_owner_id          = data.alicloud_account.current.id
  association_region_id = "cn-hangzhou"
  vpc_id                = alicloud_vpc.default8qAtD6.id
}
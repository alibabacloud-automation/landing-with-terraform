provider "alicloud" {
  region = "cn-beijing"
}

variable "name" {
  default = "tf-example"
}

variable "zone" {
  default = ["cn-beijing-i", "cn-beijing-k", "cn-beijing-l"]
}

resource "alicloud_vpc" "vpc" {
  vpc_name    = var.name
  cidr_block  = "10.2.0.0/16"
  enable_ipv6 = true
}

resource "alicloud_vswitch" "vsw" {
  count                = 2
  enable_ipv6          = true
  ipv6_cidr_block_mask = "1${count.index}"
  vswitch_name         = "vsw-${count.index}-for-nlb"
  vpc_id               = alicloud_vpc.vpc.id
  cidr_block           = "10.2.1${count.index}.0/24"
  zone_id              = var.zone[count.index]
}

resource "alicloud_vpc_ipv6_gateway" "default" {
  ipv6_gateway_name = var.name
  vpc_id            = alicloud_vpc.vpc.id
}

resource "alicloud_nlb_load_balancer" "nlb" {
  depends_on         = [alicloud_vpc_ipv6_gateway.default]
  load_balancer_name = var.name
  load_balancer_type = "Network"
  address_type       = "Intranet"
  address_ip_version = "DualStack"
  ipv6_address_type  = "Internet"
  vpc_id             = alicloud_vpc.vpc.id
  cross_zone_enabled = false
  tags = {
    Created = "TF",
    For     = "example",
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.vsw[0].id
    zone_id    = var.zone[0]
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.vsw[1].id
    zone_id    = var.zone[1]
  }
}
variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

resource "alicloud_vpc" "vpc" {
  description = "example"
  cidr_block  = "10.0.0.0/8"
  enable_ipv6 = true
  vpc_name    = "tf-exampleacc-248"
}

resource "alicloud_vswitch" "vsw1" {
  vpc_id       = alicloud_vpc.vpc.id
  zone_id      = "cn-beijing-l"
  cidr_block   = "10.0.1.0/24"
  vswitch_name = "tf-exampleacc-41"
}

resource "alicloud_vswitch" "vsw2" {
  vpc_id               = alicloud_vpc.vpc.id
  zone_id              = "cn-beijing-k"
  cidr_block           = "10.0.2.0/24"
  vswitch_name         = "tf-exampleacc-301"
  ipv6_cidr_block_mask = "8"
}

resource "alicloud_nlb_load_balancer" "nlb" {
  zone_mappings {
    vswitch_id = alicloud_vswitch.vsw1.id
    zone_id    = alicloud_vswitch.vsw1.zone_id
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.vsw2.id
    zone_id    = alicloud_vswitch.vsw2.zone_id
  }
  vpc_id       = alicloud_vpc.vpc.id
  address_type = "Intranet"
}


resource "alicloud_nlb_load_balancer_zone_shifted_attachment" "default" {
  zone_id          = alicloud_vswitch.vsw1.zone_id
  vswitch_id       = alicloud_vswitch.vsw1.id
  load_balancer_id = alicloud_nlb_load_balancer.nlb.id
}
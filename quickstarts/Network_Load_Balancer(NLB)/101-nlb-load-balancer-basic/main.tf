data "alicloud_nlb_zones" "default" {
}

resource "alicloud_vpc" "default" {
  vpc_name   = "tf-example"
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_vswitch" "default_1" {
  vpc_id     = alicloud_vpc.default.id
  zone_id    = data.alicloud_nlb_zones.default.zones.0.id
  cidr_block = "10.4.0.0/24"
}

resource "alicloud_vswitch" "default_2" {
  vpc_id     = alicloud_vpc.default.id
  zone_id    = data.alicloud_nlb_zones.default.zones.1.id
  cidr_block = "10.4.1.0/24"
}

locals {
  zone_id_1    = data.alicloud_nlb_zones.default.zones.0.id
  vswitch_id_1 = alicloud_vswitch.default_1.id
  zone_id_2    = data.alicloud_nlb_zones.default.zones.1.id
  vswitch_id_2 = alicloud_vswitch.default_2.id
}

resource "alicloud_nlb_load_balancer" "default" {
  load_balancer_name = "tf-example"
  vpc_id             = alicloud_vpc.default.id
  zone_mappings {
    vswitch_id = local.vswitch_id_1
    zone_id    = local.zone_id_1
  }
  zone_mappings {
    vswitch_id = local.vswitch_id_2
    zone_id    = local.zone_id_2
  }

  address_type = var.address_type
}
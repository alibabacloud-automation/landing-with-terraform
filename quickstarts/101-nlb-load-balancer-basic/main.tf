data "alicloud_nlb_zones" "default" {
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}

data "alicloud_vswitches" "default_1" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = data.alicloud_nlb_zones.default.zones.0.id
}

data "alicloud_vswitches" "default_2" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = data.alicloud_nlb_zones.default.zones.1.id
}

locals {
  zone_id_1    = data.alicloud_nlb_zones.default.zones.0.id
  vswitch_id_1 = data.alicloud_vswitches.default_1.ids[0]
  zone_id_2    = data.alicloud_nlb_zones.default.zones.1.id
  vswitch_id_2 = data.alicloud_vswitches.default_2.ids[0]
}

resource "alicloud_nlb_load_balancer" "default" {
  zone_mappings {
    zone_id    = local.zone_id_1
    vswitch_id = local.vswitch_id_1
  }
  zone_mappings {
    vswitch_id = local.vswitch_id_2
    zone_id    = local.zone_id_2
  }

  address_type = var.address_type_var
  vpc_id       = data.alicloud_vpcs.default.ids.0
}

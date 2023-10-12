data "alicloud_nlb_zones" "default" {
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}

data "alicloud_resource_manager_resource_groups" "default" {
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

resource "alicloud_common_bandwidth_package" "default" {
  bandwidth              = 2
  internet_charge_type   = "PayByBandwidth"
  bandwidth_package_name = var.name
  description            = "${var.name}_description"
}

resource "alicloud_nlb_load_balancer" "default" {
  deletion_protection_enabled = var.deletion_protection_enabled_var
  tags = {
    Created = "tfexample0"
    For     = "Tfexample 0"
  }
  address_type                   = var.address_type_var
  resource_group_id              = data.alicloud_resource_manager_resource_groups.default.ids.0
  vpc_id                         = data.alicloud_vpcs.default.ids.0
  load_balancer_type             = "Network"
  address_ip_version             = "Ipv4"
  modification_protection_status = var.modification_protection_status_var
  load_balancer_name             = var.name
  bandwidth_package_id           = alicloud_common_bandwidth_package.default.id
  zone_mappings {
    vswitch_id = local.vswitch_id_1
    zone_id    = local.zone_id_1
  }
  zone_mappings {
    vswitch_id = local.vswitch_id_2
    zone_id    = local.zone_id_2
  }

  deletion_protection_reason     = var.deletion_protection_reason_var
  modification_protection_reason = var.modification_protection_reason_var
  cross_zone_enabled             = var.cross_zone_enabled_var
}

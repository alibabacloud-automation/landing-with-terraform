data "alicloud_nlb_zones" "default" {
}

resource "alicloud_vpc" "default" {
  vpc_name   = "tf-example"
  cidr_block = "10.4.0.0/16"
}

data "alicloud_resource_manager_resource_groups" "default" {
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

resource "alicloud_common_bandwidth_package" "default" {
  bandwidth            = 2
  internet_charge_type = "PayByBandwidth"
  name                 = var.name
  description          = "${var.name}_description"
}

resource "alicloud_nlb_load_balancer" "default" {
  vpc_id                      = alicloud_vpc.default.id
  deletion_protection_reason  = var.deletion_protection_reason
  deletion_protection_enabled = var.deletion_protection_enabled
  zone_mappings {
    vswitch_id = local.vswitch_id_1
    zone_id    = local.zone_id_1
  }
  zone_mappings {
    vswitch_id = local.vswitch_id_2
    zone_id    = local.zone_id_2
  }

  cross_zone_enabled             = var.cross_zone_enabled
  modification_protection_status = var.modification_protection_status
  tags = {
    For     = "tf-example"
    Created = "tf-example"
  }
  address_ip_version             = "Ipv4"
  modification_protection_reason = var.modification_protection_reason
  address_type                   = var.address_type
  bandwidth_package_id           = alicloud_common_bandwidth_package.default.id
  load_balancer_name             = var.name
  resource_group_id              = data.alicloud_resource_manager_resource_groups.default.ids.0
  load_balancer_type             = "Network"
}
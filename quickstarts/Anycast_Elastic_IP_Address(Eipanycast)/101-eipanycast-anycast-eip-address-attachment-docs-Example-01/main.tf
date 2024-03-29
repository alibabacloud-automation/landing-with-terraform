provider "alicloud" {
  region = "cn-beijing"
}

variable "name" {
  default = "terraform-example"
}

data "alicloud_slb_zones" "default" {
  available_slb_address_type = "vpc"
}
resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.0.0.0/8"
}
resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "10.1.0.0/16"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_slb_zones.default.zones.0.id
}

resource "alicloud_slb_load_balancer" "default" {
  address_type       = "intranet"
  vswitch_id         = alicloud_vswitch.default.id
  load_balancer_name = var.name
  load_balancer_spec = "slb.s1.small"
  master_zone_id     = data.alicloud_slb_zones.default.zones.0.id
}

resource "alicloud_eipanycast_anycast_eip_address" "default" {
  anycast_eip_address_name = var.name
  service_location         = "ChineseMainland"
}

data "alicloud_regions" "default" {
  current = true
}

resource "alicloud_eipanycast_anycast_eip_address_attachment" "default" {
  bind_instance_id        = alicloud_slb_load_balancer.default.id
  bind_instance_type      = "SlbInstance"
  bind_instance_region_id = data.alicloud_regions.default.regions.0.id
  anycast_id              = alicloud_eipanycast_anycast_eip_address.default.id
}
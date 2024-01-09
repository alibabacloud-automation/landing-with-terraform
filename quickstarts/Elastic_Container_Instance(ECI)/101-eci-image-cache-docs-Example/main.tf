variable "name" {
  default = "tf-example"
}

data "alicloud_eci_zones" "default" {}
resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.0.0.0/8"
}
resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "10.1.0.0/16"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_eci_zones.default.zones.0.zone_ids.0
}

resource "alicloud_security_group" "default" {
  name   = var.name
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_eip_address" "default" {
  isp                       = "BGP"
  address_name              = var.name
  netmode                   = "public"
  bandwidth                 = "1"
  security_protection_types = ["AntiDDoS_Enhanced"]
  payment_type              = "PayAsYouGo"
}
data "alicloud_regions" "default" {
  current = true
}

resource "alicloud_eci_image_cache" "default" {
  image_cache_name  = var.name
  images            = ["registry-vpc.${data.alicloud_regions.default.regions.0.id}.aliyuncs.com/eci_open/nginx:alpine"]
  security_group_id = alicloud_security_group.default.id
  vswitch_id        = alicloud_vswitch.default.id
  eip_instance_id   = alicloud_eip_address.default.id
}
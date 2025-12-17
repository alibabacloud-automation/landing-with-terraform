provider "alicloud" {
  region = "cn-hangzhou"
}
variable "name" {
  default = "tfexample"
}
data "alicloud_resource_manager_resource_groups" "default" {
}
data "alicloud_account" "this" {
}
data "alicloud_regions" "default" {
  current = true
}
data "alicloud_express_connect_physical_connections" "nameRegex" {
  name_regex = "^preserved-NODELETING-JG"
}
data "alicloud_alb_zones" "default" {
}
resource "alicloud_vpc" "default" {
  vpc_name    = var.name
  cidr_block  = "172.16.0.0/16"
  enable_ipv6 = "true"
}
resource "alicloud_vswitch" "zone_a" {
  vswitch_name         = var.name
  vpc_id               = alicloud_vpc.default.id
  cidr_block           = "172.16.0.0/24"
  zone_id              = data.alicloud_alb_zones.default.zones.0.id
  ipv6_cidr_block_mask = "6"
}
resource "alicloud_express_connect_virtual_border_router" "default" {
  physical_connection_id = data.alicloud_express_connect_physical_connections.nameRegex.connections.0.id
  vlan_id                = "1001"
  peer_gateway_ip        = "192.168.254.2"
  peering_subnet_mask    = "255.255.255.0"
  local_gateway_ip       = "192.168.254.1"
}
resource "alicloud_express_connect_router_interface" "default" {
  auto_renew                  = "true"
  spec                        = "Mini.2"
  opposite_router_type        = "VRouter"
  router_id                   = alicloud_express_connect_virtual_border_router.default.id
  description                 = "terraform-example"
  access_point_id             = "ap-cn-hangzhou-jg-B"
  resource_group_id           = data.alicloud_resource_manager_resource_groups.default.ids.0
  period                      = "1"
  opposite_router_id          = alicloud_vpc.default.router_id
  role                        = "InitiatingSide"
  payment_type                = "PayAsYouGo"
  auto_pay                    = "true"
  opposite_interface_owner_id = data.alicloud_account.this.id
  router_interface_name       = var.name
  fast_link_mode              = "true"
  opposite_region_id          = "cn-hangzhou"
  router_type                 = "VBR"
}
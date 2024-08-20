variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "description" {
  default = "Created by Terraform"
}

variable "firewall_name" {
  default = "tf-example"
}

variable "tr_attachment_master_cidr" {
  default = "192.168.3.192/26"
}

variable "firewall_subnet_cidr" {
  default = "192.168.3.0/25"
}

variable "region" {
  default = "cn-hangzhou"
}

variable "tr_attachment_slave_cidr" {
  default = "192.168.3.128/26"
}

variable "firewall_vpc_cidr" {
  default = "192.168.3.0/24"
}

variable "zone1" {
  default = "cn-hangzhou-h"
}

variable "firewall_name_update" {
  default = "tf-example-1"
}

variable "zone2" {
  default = "cn-hangzhou-i"
}

data "alicloud_cen_transit_router_available_resources" "default" {
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_cen_instance" "cen" {
  description       = "terraform example"
  cen_instance_name = var.name
}

resource "alicloud_cen_transit_router" "tr" {
  transit_router_name        = var.name
  transit_router_description = "tr-created-by-terraform"
  cen_id                     = alicloud_cen_instance.cen.id
}

resource "alicloud_vpc" "vpc1" {
  description = "created by terraform"
  cidr_block  = "192.168.1.0/24"
  vpc_name    = var.name
}

resource "alicloud_vswitch" "vpc1vsw1" {
  cidr_block   = "192.168.1.0/25"
  vswitch_name = var.name
  vpc_id       = alicloud_vpc.vpc1.id
  zone_id      = data.alicloud_cen_transit_router_available_resources.default.resources[0].master_zones[1]
}

resource "alicloud_vswitch" "vpc1vsw2" {
  vpc_id       = alicloud_vpc.vpc1.id
  cidr_block   = "192.168.1.128/26"
  vswitch_name = var.name
  zone_id      = data.alicloud_cen_transit_router_available_resources.default.resources[0].master_zones[2]
}

resource "alicloud_route_table" "foo" {
  vpc_id           = alicloud_vpc.vpc1.id
  route_table_name = var.name
  description      = var.name
}

resource "alicloud_cen_transit_router_vpc_attachment" "tr-vpc1" {
  zone_mappings {
    vswitch_id = alicloud_vswitch.vpc1vsw1.id
    zone_id    = data.alicloud_cen_transit_router_available_resources.default.resources[0].master_zones[1]
  }
  zone_mappings {
    zone_id    = data.alicloud_cen_transit_router_available_resources.default.resources[0].master_zones[2]
    vswitch_id = alicloud_vswitch.vpc1vsw2.id
  }
  vpc_id            = alicloud_vpc.vpc1.id
  cen_id            = alicloud_cen_instance.cen.id
  transit_router_id = alicloud_cen_transit_router.tr.transit_router_id
  depends_on        = [alicloud_route_table.foo]
}

resource "time_sleep" "wait_10_minutes" {
  depends_on = [alicloud_cen_transit_router_vpc_attachment.tr-vpc1]

  create_duration = "10m"
}

resource "alicloud_cloud_firewall_vpc_cen_tr_firewall" "default" {
  cen_id                    = alicloud_cen_transit_router_vpc_attachment.tr-vpc1.cen_id
  firewall_name             = var.name
  firewall_subnet_cidr      = var.firewall_subnet_cidr
  tr_attachment_slave_cidr  = var.tr_attachment_slave_cidr
  firewall_description      = "VpcCenTrFirewall created by terraform"
  region_no                 = var.region
  tr_attachment_master_cidr = var.tr_attachment_master_cidr
  firewall_vpc_cidr         = var.firewall_vpc_cidr
  transit_router_id         = alicloud_cen_transit_router.tr.transit_router_id
  route_mode                = "managed"

  depends_on = [time_sleep.wait_10_minutes]
}
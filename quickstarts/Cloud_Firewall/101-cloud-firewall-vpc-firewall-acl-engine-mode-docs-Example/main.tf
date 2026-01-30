variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = ""
}

resource "alicloud_cen_instance" "cen" {
  description       = "yqc-example001"
  cen_instance_name = "yqc-example-CenInstance001"
}

resource "alicloud_cen_transit_router" "TR" {
  cen_id = alicloud_cen_instance.cen.id
}

resource "alicloud_vpc" "vpc1" {
  cidr_block = "172.16.0.0/12"
  vpc_name   = "yqc-vpc-example-001"
}

resource "alicloud_vswitch" "vpc1vsw1" {
  vpc_id     = alicloud_vpc.vpc1.id
  zone_id    = "cn-hangzhou-h"
  cidr_block = "172.16.1.0/24"
}

resource "alicloud_vswitch" "vpc1vsw2" {
  vpc_id     = alicloud_vpc.vpc1.id
  zone_id    = "cn-hangzhou-i"
  cidr_block = "172.16.2.0/24"
}

resource "alicloud_cen_transit_router_vpc_attachment" "tr-vpc1" {
  vpc_id = alicloud_vpc.vpc1.id
  cen_id = alicloud_cen_instance.cen.id
  zone_mappings {
    vswitch_id = alicloud_vswitch.vpc1vsw1.id
    zone_id    = alicloud_vswitch.vpc1vsw1.zone_id
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.vpc1vsw2.id
    zone_id    = alicloud_vswitch.vpc1vsw2.zone_id
  }
  transit_router_vpc_attachment_name    = "example"
  transit_router_attachment_description = "111"
  auto_publish_route_enabled            = true
  transit_router_id                     = alicloud_cen_transit_router.TR.transit_router_id
}


resource "alicloud_cloud_firewall_vpc_firewall_acl_engine_mode" "default" {
  strict_mode     = "0"
  vpc_firewall_id = alicloud_cen_instance.cen.id
  member_uid      = "1511928242963727"
}
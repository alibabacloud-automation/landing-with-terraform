variable "name" {
  default = "tf_example"
}
variable "region" {
  default = "cn-hangzhou"
}
variable "peer_region" {
  default = "cn-beijing"
}
provider "alicloud" {
  alias  = "hz"
  region = var.region
}
provider "alicloud" {
  alias  = "bj"
  region = var.peer_region
}

resource "alicloud_cen_instance" "example" {
  provider          = alicloud.bj
  cen_instance_name = var.name
  protection_level  = "REDUCED"
}

resource "alicloud_cen_bandwidth_package" "example" {
  provider                   = alicloud.bj
  bandwidth                  = 5
  cen_bandwidth_package_name = "tf_example"
  geographic_region_a_id     = "China"
  geographic_region_b_id     = "China"
}

resource "alicloud_cen_bandwidth_package_attachment" "example" {
  provider             = alicloud.bj
  instance_id          = alicloud_cen_instance.example.id
  bandwidth_package_id = alicloud_cen_bandwidth_package.example.id
}

resource "alicloud_cen_transit_router" "example" {
  provider = alicloud.hz
  cen_id   = alicloud_cen_bandwidth_package_attachment.example.instance_id
}

resource "alicloud_cen_transit_router" "peer" {
  provider = alicloud.bj
  cen_id   = alicloud_cen_transit_router.example.cen_id
}

resource "alicloud_cen_transit_router_peer_attachment" "example" {
  provider                              = alicloud.hz
  cen_id                                = alicloud_cen_instance.example.id
  transit_router_id                     = alicloud_cen_transit_router.example.transit_router_id
  peer_transit_router_region_id         = var.peer_region
  peer_transit_router_id                = alicloud_cen_transit_router.peer.transit_router_id
  cen_bandwidth_package_id              = alicloud_cen_bandwidth_package_attachment.example.bandwidth_package_id
  bandwidth                             = 5
  transit_router_attachment_description = var.name
  transit_router_attachment_name        = var.name
}
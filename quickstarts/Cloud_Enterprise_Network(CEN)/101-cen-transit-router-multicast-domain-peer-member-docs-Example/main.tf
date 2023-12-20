variable "name" {
  default = "tf_example"
}
provider "alicloud" {
  alias  = "hz"
  region = "cn-hangzhou"
}

provider "alicloud" {
  alias  = "qd"
  region = "cn-qingdao"
}

resource "alicloud_cen_instance" "default" {
  cen_instance_name = var.name
}

resource "alicloud_cen_bandwidth_package" "default" {
  bandwidth                  = 5
  cen_bandwidth_package_name = var.name
  geographic_region_a_id     = "China"
  geographic_region_b_id     = "China"
}

resource "alicloud_cen_bandwidth_package_attachment" "default" {
  instance_id          = alicloud_cen_instance.default.id
  bandwidth_package_id = alicloud_cen_bandwidth_package.default.id
}

resource "alicloud_cen_transit_router" "default" {
  provider          = alicloud.hz
  cen_id            = alicloud_cen_bandwidth_package_attachment.default.instance_id
  support_multicast = true
}

resource "alicloud_cen_transit_router" "peer" {
  provider          = alicloud.qd
  cen_id            = alicloud_cen_bandwidth_package_attachment.default.instance_id
  support_multicast = true
}

resource "alicloud_cen_transit_router_peer_attachment" "default" {
  provider                              = alicloud.hz
  cen_id                                = alicloud_cen_bandwidth_package_attachment.default.instance_id
  transit_router_id                     = alicloud_cen_transit_router.default.transit_router_id
  peer_transit_router_id                = alicloud_cen_transit_router.peer.transit_router_id
  peer_transit_router_region_id         = "cn-qingdao"
  cen_bandwidth_package_id              = alicloud_cen_bandwidth_package_attachment.default.bandwidth_package_id
  bandwidth                             = 5
  transit_router_attachment_description = var.name
  transit_router_attachment_name        = var.name
}

resource "alicloud_cen_transit_router_multicast_domain" "default" {
  provider                                    = alicloud.hz
  transit_router_id                           = alicloud_cen_transit_router_peer_attachment.default.transit_router_id
  transit_router_multicast_domain_name        = var.name
  transit_router_multicast_domain_description = var.name
}

resource "alicloud_cen_transit_router_multicast_domain" "peer" {
  provider                                    = alicloud.qd
  transit_router_id                           = alicloud_cen_transit_router_peer_attachment.default.peer_transit_router_id
  transit_router_multicast_domain_name        = var.name
  transit_router_multicast_domain_description = var.name
}

resource "alicloud_cen_transit_router_multicast_domain_peer_member" "default" {
  provider                                = alicloud.hz
  transit_router_multicast_domain_id      = alicloud_cen_transit_router_multicast_domain.default.id
  peer_transit_router_multicast_domain_id = alicloud_cen_transit_router_multicast_domain.peer.id
  group_ip_address                        = "224.0.0.1"
}
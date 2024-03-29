variable "name" {
  default = "tf_example"
}
variable "default_region" {
  default = "cn-hangzhou"
}
variable "peer_region" {
  default = "cn-beijing"
}
provider "alicloud" {
  alias  = "hz"
  region = var.default_region
}
provider "alicloud" {
  alias  = "bj"
  region = var.peer_region
}

resource "alicloud_cen_instance" "default" {
  cen_instance_name = var.name
  protection_level  = "REDUCED"
}

resource "alicloud_cen_bandwidth_package" "default" {
  provider                   = alicloud.hz
  bandwidth                  = 5
  cen_bandwidth_package_name = "tf_example"
  geographic_region_a_id     = "China"
  geographic_region_b_id     = "China"
}

resource "alicloud_cen_bandwidth_package_attachment" "default" {
  provider             = alicloud.hz
  instance_id          = alicloud_cen_instance.default.id
  bandwidth_package_id = alicloud_cen_bandwidth_package.default.id
}

resource "alicloud_cen_transit_router" "default" {
  provider          = alicloud.hz
  cen_id            = alicloud_cen_instance.default.id
  support_multicast = true
}

resource "alicloud_cen_transit_router" "peer" {
  provider          = alicloud.bj
  cen_id            = alicloud_cen_transit_router.default.cen_id
  support_multicast = true
}

resource "alicloud_cen_transit_router_peer_attachment" "default" {
  provider                              = alicloud.hz
  cen_id                                = alicloud_cen_instance.default.id
  transit_router_id                     = alicloud_cen_transit_router.default.transit_router_id
  peer_transit_router_region_id         = var.peer_region
  peer_transit_router_id                = alicloud_cen_transit_router.peer.transit_router_id
  cen_bandwidth_package_id              = alicloud_cen_bandwidth_package_attachment.default.bandwidth_package_id
  bandwidth                             = 5
  transit_router_attachment_description = var.name
  transit_router_attachment_name        = var.name
}

resource "alicloud_cen_inter_region_traffic_qos_policy" "default" {
  provider                                    = alicloud.hz
  transit_router_id                           = alicloud_cen_transit_router.default.transit_router_id
  transit_router_attachment_id                = alicloud_cen_transit_router_peer_attachment.default.transit_router_attachment_id
  inter_region_traffic_qos_policy_name        = var.name
  inter_region_traffic_qos_policy_description = var.name
}

resource "alicloud_cen_inter_region_traffic_qos_queue" "default" {
  remain_bandwidth_percent                   = 20
  traffic_qos_policy_id                      = alicloud_cen_inter_region_traffic_qos_policy.default.id
  dscps                                      = [1, 2]
  inter_region_traffic_qos_queue_description = var.name
}
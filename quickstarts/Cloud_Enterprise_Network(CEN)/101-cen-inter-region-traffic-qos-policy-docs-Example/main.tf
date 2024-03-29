provider "alicloud" {
  alias  = "bj"
  region = "cn-beijing"
}

provider "alicloud" {
  alias  = "hz"
  region = "cn-hangzhou"
}

resource "alicloud_cen_instance" "default" {
  provider          = alicloud.hz
  cen_instance_name = "tf-example"
}

resource "alicloud_cen_bandwidth_package" "default" {
  provider               = alicloud.hz
  bandwidth              = 5
  geographic_region_a_id = "China"
  geographic_region_b_id = "China"
}

resource "alicloud_cen_bandwidth_package_attachment" "default" {
  provider             = alicloud.hz
  instance_id          = alicloud_cen_instance.default.id
  bandwidth_package_id = alicloud_cen_bandwidth_package.default.id
}

resource "alicloud_cen_transit_router" "hz" {
  provider = alicloud.hz
  cen_id   = alicloud_cen_bandwidth_package_attachment.default.instance_id
}

resource "alicloud_cen_transit_router" "bj" {
  provider = alicloud.bj
  cen_id   = alicloud_cen_transit_router.hz.cen_id
}

resource "alicloud_cen_transit_router_peer_attachment" "default" {
  provider                      = alicloud.hz
  cen_id                        = alicloud_cen_instance.default.id
  transit_router_id             = alicloud_cen_transit_router.hz.transit_router_id
  peer_transit_router_region_id = "cn-beijing"
  peer_transit_router_id        = alicloud_cen_transit_router.bj.transit_router_id
  cen_bandwidth_package_id      = alicloud_cen_bandwidth_package_attachment.default.bandwidth_package_id
  bandwidth                     = 5
}

resource "alicloud_cen_inter_region_traffic_qos_policy" "default" {
  provider                                    = alicloud.hz
  transit_router_id                           = alicloud_cen_transit_router.hz.transit_router_id
  transit_router_attachment_id                = alicloud_cen_transit_router_peer_attachment.default.transit_router_attachment_id
  inter_region_traffic_qos_policy_name        = "tf-example-name"
  inter_region_traffic_qos_policy_description = "tf-example-description"
}
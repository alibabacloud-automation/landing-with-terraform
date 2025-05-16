variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
  alias  = "hz"
}

provider "alicloud" {
  region = "cn-beijing"
  alias  = "bj"
}

resource "alicloud_cen_instance" "defaultpSZB78" {
}

resource "alicloud_cen_transit_router" "defaultUmmxnE" {
  provider = alicloud.bj
  cen_id   = alicloud_cen_instance.defaultpSZB78.id
}

resource "alicloud_cen_transit_router" "defaultksqgSa" {
  provider = alicloud.hz
  cen_id   = alicloud_cen_instance.defaultpSZB78.id
}

resource "alicloud_cen_transit_router_peer_attachment" "defaultnXZ83y" {
  provider                      = alicloud.bj
  default_link_type             = "Platinum"
  bandwidth_type                = "DataTransfer"
  cen_id                        = alicloud_cen_instance.defaultpSZB78.id
  peer_transit_router_region_id = "cn-hangzhou"
  transit_router_id             = alicloud_cen_transit_router.defaultUmmxnE.transit_router_id
  peer_transit_router_id        = alicloud_cen_transit_router.defaultksqgSa.transit_router_id
  bandwidth                     = "10"
}


resource "alicloud_cen_inter_region_traffic_qos_policy" "default" {
  provider                                    = alicloud.bj
  transit_router_attachment_id                = alicloud_cen_transit_router_peer_attachment.defaultnXZ83y.transit_router_attachment_id
  inter_region_traffic_qos_policy_name        = "example1"
  inter_region_traffic_qos_policy_description = "example1"
  bandwidth_guarantee_mode                    = "byBandwidthPercent"
  transit_router_id                           = alicloud_cen_transit_router.defaultksqgSa.transit_router_id
}
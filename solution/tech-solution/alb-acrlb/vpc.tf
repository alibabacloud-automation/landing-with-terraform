# VPC 资源
resource "alicloud_vpc" "vpc1" {
  provider   = alicloud.region1
  vpc_name   = "vpc1_test"
  cidr_block = var.vpc1_cidr
}

resource "alicloud_vswitch" "vsw11" {
  provider   = alicloud.region1
  vpc_id     = alicloud_vpc.vpc1.id
  cidr_block = var.vsw11_cidr
  zone_id    = var.zone11_id
}

resource "alicloud_vswitch" "vsw12" {
  provider   = alicloud.region1
  vpc_id     = alicloud_vpc.vpc1.id
  cidr_block = var.vsw12_cidr
  zone_id    = var.zone12_id
}

resource "alicloud_vpc" "vpc2" {
  provider   = alicloud.region2
  vpc_name   = "vpc2_test"
  cidr_block = var.vpc2_cidr
}

resource "alicloud_vswitch" "vsw21" {
  provider   = alicloud.region2
  vpc_id     = alicloud_vpc.vpc2.id
  cidr_block = var.vsw21_cidr
  zone_id    = var.zone21_id
}

resource "alicloud_vswitch" "vsw22" {
  provider   = alicloud.region2
  vpc_id     = alicloud_vpc.vpc2.id
  cidr_block = var.vsw22_cidr
  zone_id    = var.zone22_id
}

resource "alicloud_vpc" "vpc3" {
  provider   = alicloud.region3
  vpc_name   = "vpc3_test"
  cidr_block = var.vpc3_cidr
}

resource "alicloud_vswitch" "vsw31" {
  provider   = alicloud.region3
  vpc_id     = alicloud_vpc.vpc3.id
  cidr_block = var.vsw31_cidr
  zone_id    = var.zone31_id
}

resource "alicloud_vswitch" "vsw32" {
  provider   = alicloud.region3
  vpc_id     = alicloud_vpc.vpc3.id
  cidr_block = var.vsw32_cidr
  zone_id    = var.zone32_id
}

# VPC 路由条目
resource "alicloud_route_entry" "vpc1_route_entry" {
  provider              = alicloud.region1
  for_each              = toset([var.vpc1_cidr, var.vpc2_cidr, var.vpc3_cidr, var.vsw21_cidr, var.vsw31_cidr])
  route_table_id        = alicloud_vpc.vpc1.route_table_id
  destination_cidrblock = each.key
  nexthop_type          = "Attachment"
  nexthop_id            = alicloud_cen_transit_router_vpc_attachment.vpc_att1.transit_router_attachment_id
}

resource "alicloud_route_entry" "vpc2_route_entry" {
  provider              = alicloud.region2
  for_each              = toset([var.vpc1_cidr, var.vpc2_cidr, var.vpc3_cidr, var.alb_chengdu_back_to_source_routing_cidr1, var.alb_chengdu_back_to_source_routing_cidr2, var.alb_chengdu_back_to_source_routing_cidr3, var.alb_chengdu_back_to_source_routing_cidr4, var.alb_chengdu_back_to_source_routing_cidr5, var.alb_chengdu_back_to_source_routing_cidr6, var.alb_chengdu_back_to_source_routing_cidr7, var.alb_chengdu_back_to_source_routing_cidr8])
  route_table_id        = alicloud_vpc.vpc2.route_table_id
  destination_cidrblock = each.key
  nexthop_type          = "Attachment"
  nexthop_id            = alicloud_cen_transit_router_vpc_attachment.vpc_att2.transit_router_attachment_id
}

resource "alicloud_route_entry" "vpc3_route_entry" {
  provider              = alicloud.region3
  for_each              = toset([var.vpc1_cidr, var.vpc2_cidr, var.vpc3_cidr, var.alb_chengdu_back_to_source_routing_cidr1, var.alb_chengdu_back_to_source_routing_cidr2, var.alb_chengdu_back_to_source_routing_cidr3, var.alb_chengdu_back_to_source_routing_cidr4, var.alb_chengdu_back_to_source_routing_cidr5, var.alb_chengdu_back_to_source_routing_cidr6, var.alb_chengdu_back_to_source_routing_cidr7, var.alb_chengdu_back_to_source_routing_cidr8])
  route_table_id        = alicloud_vpc.vpc3.route_table_id
  destination_cidrblock = each.key
  nexthop_type          = "Attachment"
  nexthop_id            = alicloud_cen_transit_router_vpc_attachment.vpc_att3.transit_router_attachment_id
}
# CEN 相关资源
resource "alicloud_cen_instance" "cen" {
  provider          = alicloud.region1
  cen_instance_name = "cen-test"
}

data "alicloud_cen_transit_router_service" "open" {
  enable = "On"
}

# Transit Router 实例
resource "alicloud_cen_transit_router" "tr1" {
  provider            = alicloud.region1
  transit_router_name = "TR1"
  cen_id              = alicloud_cen_instance.cen.id
  depends_on          = [data.alicloud_cen_transit_router_service.open]
}

resource "alicloud_cen_transit_router" "tr2" {
  provider            = alicloud.region2
  transit_router_name = "TR2"
  cen_id              = alicloud_cen_instance.cen.id
  depends_on          = [data.alicloud_cen_transit_router_service.open]
}

resource "alicloud_cen_transit_router" "tr3" {
  provider            = alicloud.region3
  transit_router_name = "TR3"
  cen_id              = alicloud_cen_instance.cen.id
  depends_on          = [data.alicloud_cen_transit_router_service.open]
}

# VPC 连接至 Transit Router
resource "alicloud_cen_transit_router_vpc_attachment" "vpc_att1" {
  provider          = alicloud.region1
  cen_id            = alicloud_cen_instance.cen.id
  transit_router_id = alicloud_cen_transit_router.tr1.transit_router_id
  vpc_id            = alicloud_vpc.vpc1.id
  zone_mappings {
    zone_id    = var.zone11_id
    vswitch_id = alicloud_vswitch.vsw11.id
  }
  zone_mappings {
    zone_id    = var.zone12_id
    vswitch_id = alicloud_vswitch.vsw12.id
  }
}

resource "alicloud_cen_transit_router_vpc_attachment" "vpc_att2" {
  provider          = alicloud.region2
  cen_id            = alicloud_cen_instance.cen.id
  transit_router_id = alicloud_cen_transit_router.tr2.transit_router_id
  vpc_id            = alicloud_vpc.vpc2.id
  zone_mappings {
    zone_id    = var.zone21_id
    vswitch_id = alicloud_vswitch.vsw21.id
  }
  zone_mappings {
    zone_id    = var.zone22_id
    vswitch_id = alicloud_vswitch.vsw22.id
  }
}

resource "alicloud_cen_transit_router_vpc_attachment" "vpc_att3" {
  provider          = alicloud.region3
  cen_id            = alicloud_cen_instance.cen.id
  transit_router_id = alicloud_cen_transit_router.tr3.transit_router_id
  vpc_id            = alicloud_vpc.vpc3.id
  zone_mappings {
    zone_id    = var.zone31_id
    vswitch_id = alicloud_vswitch.vsw31.id
  }
  zone_mappings {
    zone_id    = var.zone32_id
    vswitch_id = alicloud_vswitch.vsw32.id
  }
}

# Transit Router 路由表
resource "alicloud_cen_transit_router_route_table" "tr1_route_table" {
  provider          = alicloud.region1
  transit_router_id = alicloud_cen_transit_router.tr1.transit_router_id
}

resource "alicloud_cen_transit_router_route_table_association" "tr1_table_association" {
  provider                      = alicloud.region1
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr1_route_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.vpc_att1.transit_router_attachment_id
}

resource "alicloud_cen_transit_router_route_table_propagation" "tr1_table_propagation" {
  provider                      = alicloud.region1
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr1_route_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.vpc_att1.transit_router_attachment_id
}

resource "alicloud_cen_transit_router_route_table" "tr2_route_table" {
  provider          = alicloud.region2
  transit_router_id = alicloud_cen_transit_router.tr2.transit_router_id
}

resource "alicloud_cen_transit_router_route_table_association" "tr2_table_association" {
  provider                      = alicloud.region2
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr2_route_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.vpc_att2.transit_router_attachment_id
}

resource "alicloud_cen_transit_router_route_table_propagation" "tr2_table_propagation" {
  provider                      = alicloud.region2
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr2_route_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.vpc_att2.transit_router_attachment_id
}

resource "alicloud_cen_transit_router_route_table" "tr3_route_table" {
  provider          = alicloud.region3
  transit_router_id = alicloud_cen_transit_router.tr3.transit_router_id
}

resource "alicloud_cen_transit_router_route_table_association" "tr3_table_association" {
  provider                      = alicloud.region3
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr3_route_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.vpc_att3.transit_router_attachment_id
}

resource "alicloud_cen_transit_router_route_table_propagation" "tr3_table_propagation" {
  provider                      = alicloud.region3
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr3_route_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.vpc_att3.transit_router_attachment_id
}

# Transit Router 路由条目
resource "alicloud_cen_transit_router_route_entry" "tr1_route_entry" {
  provider                                          = alicloud.region1
  for_each                                          = toset([var.alb_chengdu_back_to_source_routing_cidr1, var.alb_chengdu_back_to_source_routing_cidr2, var.alb_chengdu_back_to_source_routing_cidr3, var.alb_chengdu_back_to_source_routing_cidr4, var.alb_chengdu_back_to_source_routing_cidr5, var.alb_chengdu_back_to_source_routing_cidr6, var.alb_chengdu_back_to_source_routing_cidr7, var.alb_chengdu_back_to_source_routing_cidr8])
  transit_router_route_table_id                     = alicloud_cen_transit_router_route_table.tr1_route_table.transit_router_route_table_id
  transit_router_route_entry_destination_cidr_block = each.key
  transit_router_route_entry_next_hop_type          = "Attachment"
  transit_router_route_entry_next_hop_id            = alicloud_cen_transit_router_vpc_attachment.vpc_att1.transit_router_attachment_id
}

# Transit Router 对等连接
resource "alicloud_cen_transit_router_peer_attachment" "peer12_attachment" {
  provider                            = alicloud.region1
  transit_router_peer_attachment_name = "TR1-TR2-Cross-Region-Test"
  cen_id                              = alicloud_cen_instance.cen.id
  transit_router_id                   = alicloud_cen_transit_router.tr1.transit_router_id
  peer_transit_router_region_id       = var.region2
  peer_transit_router_id              = alicloud_cen_transit_router.tr2.transit_router_id
  auto_publish_route_enabled          = true
}

# tr12之间配置路由及学习关系
resource "alicloud_cen_transit_router_route_table_association" "tr1_association12" {
  provider                      = alicloud.region1
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr1_route_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.peer12_attachment.transit_router_attachment_id
}

resource "alicloud_cen_transit_router_route_table_propagation" "tr1_propagation12" {
  provider                      = alicloud.region1
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr1_route_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.peer12_attachment.transit_router_attachment_id
}

resource "alicloud_cen_transit_router_route_table_association" "tr1_association21" {
  provider                      = alicloud.region2
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr2_route_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.peer12_attachment.transit_router_attachment_id
}

resource "alicloud_cen_transit_router_route_table_propagation" "tr1_propagation21" {
  provider                      = alicloud.region2
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr2_route_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.peer12_attachment.transit_router_attachment_id
}

resource "alicloud_cen_transit_router_peer_attachment" "peer13_attachment" {
  provider                            = alicloud.region1
  transit_router_peer_attachment_name = "TR1-TR3-Cross-Region-Test"
  cen_id                              = alicloud_cen_instance.cen.id
  transit_router_id                   = alicloud_cen_transit_router.tr1.transit_router_id
  peer_transit_router_region_id       = var.region3
  peer_transit_router_id              = alicloud_cen_transit_router.tr3.transit_router_id
  auto_publish_route_enabled          = true
}

# tr13之间配置路由及学习关系
resource "alicloud_cen_transit_router_route_table_association" "tr1_association13" {
  provider                      = alicloud.region1
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr1_route_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.peer13_attachment.transit_router_attachment_id
}

resource "alicloud_cen_transit_router_route_table_propagation" "tr1_propagation13" {
  provider                      = alicloud.region1
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr1_route_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.peer13_attachment.transit_router_attachment_id
}

resource "alicloud_cen_transit_router_route_table_association" "tr1_association31" {
  provider                      = alicloud.region3
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr3_route_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.peer13_attachment.transit_router_attachment_id
}

resource "alicloud_cen_transit_router_route_table_propagation" "tr1_propagation31" {
  provider                      = alicloud.region3
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr3_route_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.peer13_attachment.transit_router_attachment_id
}
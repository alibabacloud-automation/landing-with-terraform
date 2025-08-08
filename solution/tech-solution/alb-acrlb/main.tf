data "alicloud_instance_types" "types1" {
  provider             = alicloud.region1
  availability_zone    = var.zone11_id
  system_disk_category = var.system_disk_category
}

data "alicloud_instance_types" "types2" {
  provider             = alicloud.region2
  availability_zone    = var.zone21_id
  system_disk_category = var.system_disk_category
}

data "alicloud_instance_types" "types3" {
  provider             = alicloud.region3
  availability_zone    = var.zone31_id
  system_disk_category = var.system_disk_category
}


locals {
  create_ecs = true
  cen_name   = "cen-test"
  tr1_name   = "TR1"
  tr2_name   = "TR2"
  tr3_name   = "TR3"
  region1    = var.region1
  region2    = var.region2
  region3    = var.region3
  # 从数据源获取每个region的可用区
  zone11_id                                = var.zone11_id
  zone12_id                                = var.zone12_id
  zone21_id                                = var.zone21_id
  zone22_id                                = var.zone22_id
  zone31_id                                = var.zone31_id
  zone32_id                                = var.zone32_id
  vpc1_cidr                                = "172.16.0.0/16"
  vsw11_cidr                               = "172.16.20.0/24"
  vsw12_cidr                               = "172.16.21.0/24"
  vpc2_cidr                                = "10.0.0.0/16"
  vsw21_cidr                               = "10.0.20.0/24"
  vsw22_cidr                               = "10.0.21.0/24"
  vpc3_cidr                                = "192.168.0.0/16"
  vsw31_cidr                               = "192.168.20.0/24"
  vsw32_cidr                               = "192.168.21.0/24"
  alb_chengdu_back_to_source_routing_cidr1 = "100.117.130.0/25"
  alb_chengdu_back_to_source_routing_cidr2 = "100.117.130.128/25"
  alb_chengdu_back_to_source_routing_cidr3 = "100.117.131.0/25"
  alb_chengdu_back_to_source_routing_cidr4 = "100.117.131.128/25"
  alb_chengdu_back_to_source_routing_cidr5 = "100.122.175.64/26"
  alb_chengdu_back_to_source_routing_cidr6 = "100.122.175.128/26"
  alb_chengdu_back_to_source_routing_cidr7 = "100.122.175.192/26"
  alb_chengdu_back_to_source_routing_cidr8 = "100.122.176.0/26"
}

# 定义环境
provider "alicloud" {
  alias  = "region1"
  region = local.region1
}

provider "alicloud" {
  alias  = "region2"
  region = local.region2
}

provider "alicloud" {
  alias  = "region3"
  region = local.region3
}

# cen实例
resource "alicloud_cen_instance" "cen" {
  provider          = alicloud.region1
  cen_instance_name = local.cen_name
}

data "alicloud_cen_transit_router_service" "open" {
  enable = "On"
}


# tr实例
resource "alicloud_cen_transit_router" "tr1" {
  provider            = alicloud.region1
  transit_router_name = local.tr1_name
  cen_id              = alicloud_cen_instance.cen.id
  depends_on          = [data.alicloud_cen_transit_router_service.open]
}

resource "alicloud_cen_transit_router" "tr2" {
  provider            = alicloud.region2
  transit_router_name = local.tr2_name
  cen_id              = alicloud_cen_instance.cen.id
  depends_on          = [data.alicloud_cen_transit_router_service.open]
}

resource "alicloud_cen_transit_router" "tr3" {
  provider            = alicloud.region3
  transit_router_name = local.tr3_name
  cen_id              = alicloud_cen_instance.cen.id
  depends_on          = [data.alicloud_cen_transit_router_service.open]
}

# vpc连接至tr
resource "alicloud_cen_transit_router_vpc_attachment" "vpc_att1" {
  provider          = alicloud.region1
  cen_id            = alicloud_cen_instance.cen.id
  transit_router_id = alicloud_cen_transit_router.tr1.transit_router_id
  vpc_id            = module.vpc1.vpc_id
  zone_mappings {
    zone_id    = local.zone11_id
    vswitch_id = module.vpc1.vsw1_id
  }
  zone_mappings {
    zone_id    = local.zone12_id
    vswitch_id = module.vpc1.vsw2_id
  }
}

resource "alicloud_cen_transit_router_vpc_attachment" "vpc_att2" {
  provider          = alicloud.region2
  cen_id            = alicloud_cen_instance.cen.id
  transit_router_id = alicloud_cen_transit_router.tr2.transit_router_id
  vpc_id            = module.vpc2.vpc_id
  zone_mappings {
    zone_id    = local.zone21_id
    vswitch_id = module.vpc2.vsw1_id
  }
  zone_mappings {
    zone_id    = local.zone22_id
    vswitch_id = module.vpc2.vsw2_id
  }
}

resource "alicloud_cen_transit_router_vpc_attachment" "vpc_att3" {
  provider          = alicloud.region3
  cen_id            = alicloud_cen_instance.cen.id
  transit_router_id = alicloud_cen_transit_router.tr3.transit_router_id
  vpc_id            = module.vpc3.vpc_id
  zone_mappings {
    zone_id    = local.zone31_id
    vswitch_id = module.vpc3.vsw1_id
  }
  zone_mappings {
    zone_id    = local.zone32_id
    vswitch_id = module.vpc3.vsw2_id
  }
}

# 配置tr路由及学习关系
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

# 自定义vpc路由条目
resource "alicloud_route_entry" "vpc1_route_entry" {
  provider              = alicloud.region1
  for_each              = toset([local.vpc1_cidr, local.vpc2_cidr, local.vpc3_cidr, local.vsw21_cidr, local.vsw31_cidr])
  route_table_id        = module.vpc1.route_table_id
  destination_cidrblock = each.key
  nexthop_type          = "Attachment"
  nexthop_id            = alicloud_cen_transit_router_vpc_attachment.vpc_att1.transit_router_attachment_id
}

resource "alicloud_route_entry" "vpc2_route_entry" {
  provider              = alicloud.region2
  for_each              = toset([local.vpc1_cidr, local.vpc2_cidr, local.vpc3_cidr, local.alb_chengdu_back_to_source_routing_cidr1, local.alb_chengdu_back_to_source_routing_cidr2, local.alb_chengdu_back_to_source_routing_cidr3, local.alb_chengdu_back_to_source_routing_cidr4, local.alb_chengdu_back_to_source_routing_cidr5, local.alb_chengdu_back_to_source_routing_cidr6, local.alb_chengdu_back_to_source_routing_cidr7, local.alb_chengdu_back_to_source_routing_cidr8])
  route_table_id        = module.vpc2.route_table_id
  destination_cidrblock = each.key
  nexthop_type          = "Attachment"
  nexthop_id            = alicloud_cen_transit_router_vpc_attachment.vpc_att2.transit_router_attachment_id
}

resource "alicloud_route_entry" "vpc3_route_entry" {
  provider              = alicloud.region3
  for_each              = toset([local.vpc1_cidr, local.vpc2_cidr, local.vpc3_cidr, local.alb_chengdu_back_to_source_routing_cidr1, local.alb_chengdu_back_to_source_routing_cidr2, local.alb_chengdu_back_to_source_routing_cidr3, local.alb_chengdu_back_to_source_routing_cidr4, local.alb_chengdu_back_to_source_routing_cidr5, local.alb_chengdu_back_to_source_routing_cidr6, local.alb_chengdu_back_to_source_routing_cidr7, local.alb_chengdu_back_to_source_routing_cidr8])
  route_table_id        = module.vpc3.route_table_id
  destination_cidrblock = each.key
  nexthop_type          = "Attachment"
  nexthop_id            = alicloud_cen_transit_router_vpc_attachment.vpc_att3.transit_router_attachment_id
}

# tr1添加路由
resource "alicloud_cen_transit_router_route_entry" "tr1_route_entry" {
  provider                                          = alicloud.region1
  for_each                                          = toset([local.alb_chengdu_back_to_source_routing_cidr1, local.alb_chengdu_back_to_source_routing_cidr2, local.alb_chengdu_back_to_source_routing_cidr3, local.alb_chengdu_back_to_source_routing_cidr4, local.alb_chengdu_back_to_source_routing_cidr5, local.alb_chengdu_back_to_source_routing_cidr6, local.alb_chengdu_back_to_source_routing_cidr7, local.alb_chengdu_back_to_source_routing_cidr8])
  transit_router_route_table_id                     = alicloud_cen_transit_router_route_table.tr1_route_table.transit_router_route_table_id
  transit_router_route_entry_destination_cidr_block = each.key
  transit_router_route_entry_next_hop_type          = "Attachment"
  transit_router_route_entry_next_hop_id            = alicloud_cen_transit_router_vpc_attachment.vpc_att1.transit_router_attachment_id
}

# tr12跨地域连接
resource "alicloud_cen_transit_router_peer_attachment" "peer12_attachment" {
  provider                       = alicloud.region1
  transit_router_attachment_name = "TR1-TR2-Cross-Region-Test"
  cen_id                         = alicloud_cen_instance.cen.id
  transit_router_id              = alicloud_cen_transit_router.tr1.transit_router_id
  peer_transit_router_region_id  = local.region2
  peer_transit_router_id         = alicloud_cen_transit_router.tr2.transit_router_id
  auto_publish_route_enabled     = true
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
  provider                      = alicloud.region1
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr2_route_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.peer12_attachment.transit_router_attachment_id
}

resource "alicloud_cen_transit_router_route_table_propagation" "tr1_propagation21" {
  provider                      = alicloud.region1
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr2_route_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.peer12_attachment.transit_router_attachment_id
}

# tr13跨地域连接
resource "alicloud_cen_transit_router_peer_attachment" "peer13_attachment" {
  provider                       = alicloud.region1
  transit_router_attachment_name = "TR1-TR3-Cross-Region-Test"
  cen_id                         = alicloud_cen_instance.cen.id
  transit_router_id              = alicloud_cen_transit_router.tr1.transit_router_id
  peer_transit_router_region_id  = local.region3
  peer_transit_router_id         = alicloud_cen_transit_router.tr3.transit_router_id
  auto_publish_route_enabled     = true
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
  provider                      = alicloud.region1
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr3_route_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.peer13_attachment.transit_router_attachment_id
}

resource "alicloud_cen_transit_router_route_table_propagation" "tr1_propagation31" {
  provider                      = alicloud.region1
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr3_route_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.peer13_attachment.transit_router_attachment_id
}

# vpc实例
module "vpc1" {
  source = "./vpc"
  providers = {
    alicloud : alicloud.region1
  }
  vpc_cidr  = local.vpc1_cidr
  vsw1_cidr = local.vsw11_cidr
  vsw2_cidr = local.vsw12_cidr
  zone1_id  = local.zone11_id
  zone2_id  = local.zone12_id
}

module "vpc2" {
  source = "./vpc"
  providers = {
    alicloud : alicloud.region2
  }
  vpc_cidr  = local.vpc2_cidr
  vsw1_cidr = local.vsw21_cidr
  vsw2_cidr = local.vsw22_cidr
  zone1_id  = local.zone21_id
  zone2_id  = local.zone22_id
}

module "vpc3" {
  source = "./vpc"
  providers = {
    alicloud : alicloud.region3
  }
  vpc_cidr  = local.vpc3_cidr
  vsw1_cidr = local.vsw31_cidr
  vsw2_cidr = local.vsw32_cidr
  zone1_id  = local.zone31_id
  zone2_id  = local.zone32_id
}

# ecs实例
module "ecs1" {
  source = "./ecs"
  providers = {
    alicloud : alicloud.region1
  }
  create_ecs           = local.create_ecs
  vpc_id               = module.vpc1.vpc_id
  vsw_id               = module.vpc1.vsw1_id
  zone_id              = local.zone11_id
  instance_type        = data.alicloud_instance_types.types1.ids.0
  system_disk_category = var.system_disk_category
  ecs_password         = var.ecs_password
  instance_name        = "ECS1"
  install_script       = file("${path.cwd}/scripts/install_nginx_ecs1.sh")
}

module "ecs2" {
  source = "./ecs"
  providers = {
    alicloud : alicloud.region2
  }
  create_ecs           = local.create_ecs
  vpc_id               = module.vpc2.vpc_id
  vsw_id               = module.vpc2.vsw1_id
  zone_id              = local.zone21_id
  instance_type        = data.alicloud_instance_types.types2.ids.0
  system_disk_category = var.system_disk_category
  ecs_password         = var.ecs_password
  instance_name        = "ECS2"
  install_script       = file("${path.cwd}/scripts/install_nginx_ecs2.sh")
}

module "ecs3" {
  source = "./ecs"
  providers = {
    alicloud : alicloud.region3
  }
  create_ecs           = local.create_ecs
  vpc_id               = module.vpc3.vpc_id
  vsw_id               = module.vpc3.vsw1_id
  zone_id              = local.zone31_id
  instance_type        = data.alicloud_instance_types.types3.ids.0
  system_disk_category = var.system_disk_category
  ecs_password         = var.ecs_password
  instance_name        = "ECS3"
  install_script       = file("${path.cwd}/scripts/install_nginx_ecs3.sh")
}

# alb实例
module "alb" {
  source = "./alb"
  providers = {
    alicloud : alicloud.region1
  }
  vpc_id    = module.vpc1.vpc_id
  vsw1_id   = module.vpc1.vsw1_id
  zone11_id = local.zone11_id
  vsw2_id   = module.vpc1.vsw2_id
  zone12_id = local.zone12_id
  ecs2_ip   = module.ecs2.ecs_ip
  ecs3_ip   = module.ecs3.ecs_ip
}
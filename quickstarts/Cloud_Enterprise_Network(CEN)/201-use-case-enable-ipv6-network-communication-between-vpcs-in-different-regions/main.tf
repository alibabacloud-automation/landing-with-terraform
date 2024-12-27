variable "pname" {
  description = "The prefix name for resources"
  type        = string
  default     = "tf-CenIpv6"
}

variable "default_region_id" {
  description = "The default region id"
  type        = string
  default     = "cn-hangzhou"
}

variable "hangzhou_region_id" {
  description = "The hangzhou region id"
  type        = string
  default     = "cn-hangzhou"
}

variable "shanghai_region_id" {
  description = "The shanghai region id"
  type        = string
  default     = "cn-shanghai"
}

variable "hangzhou_az_list" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["cn-hangzhou-j", "cn-hangzhou-k"]
}

variable "shanghai_az_list" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["cn-shanghai-m", "cn-shanghai-n"]
}

# --- provider ---
provider "alicloud" { # default hangzhou
  region = var.default_region_id
}

provider "alicloud" {
  alias  = "hangzhou"
  region = var.hangzhou_region_id
}

provider "alicloud" {
  alias  = "shanghai"
  region = var.shanghai_region_id
}

# --- 2 vpc and 4 vsw ---
resource "alicloud_vpc" "vpc1" {
  provider    = alicloud.hangzhou
  vpc_name    = "${var.pname}-vpc1"
  cidr_block  = "10.0.0.0/16"
  enable_ipv6 = true
}
resource "alicloud_vpc" "vpc2" {
  provider    = alicloud.shanghai
  vpc_name    = "${var.pname}-vpc2"
  cidr_block  = "172.16.0.0/16"
  enable_ipv6 = true
}
resource "alicloud_vswitch" "vsw1-1" {
  provider             = alicloud.hangzhou
  vpc_id               = alicloud_vpc.vpc1.id
  cidr_block           = "10.0.0.0/24"
  zone_id              = var.hangzhou_az_list[0]
  vswitch_name         = "${var.pname}-vsw1-1"
  enable_ipv6          = true
  ipv6_cidr_block_mask = 1 # existed
}
resource "alicloud_vswitch" "vsw1-2" {
  provider             = alicloud.hangzhou
  vpc_id               = alicloud_vpc.vpc1.id
  cidr_block           = "10.0.1.0/24"
  zone_id              = var.hangzhou_az_list[1]
  vswitch_name         = "${var.pname}-vsw1-2"
  enable_ipv6          = true
  ipv6_cidr_block_mask = 2
}
resource "alicloud_vswitch" "vsw2-1" {
  provider             = alicloud.shanghai
  vpc_id               = alicloud_vpc.vpc2.id
  cidr_block           = "172.16.0.0/24"
  zone_id              = var.shanghai_az_list[0]
  vswitch_name         = "${var.pname}-vsw2-1"
  enable_ipv6          = true
  ipv6_cidr_block_mask = 3
}
resource "alicloud_vswitch" "vsw2-2" {
  provider             = alicloud.shanghai
  vpc_id               = alicloud_vpc.vpc2.id
  cidr_block           = "172.16.1.0/24"
  zone_id              = var.shanghai_az_list[1]
  vswitch_name         = "${var.pname}-vsw2-2"
  enable_ipv6          = true
  ipv6_cidr_block_mask = 4
}

# --- ecs1 ---
resource "alicloud_instance" "ecs1" {
  provider             = alicloud.hangzhou
  instance_name        = "${var.pname}-ecs1"
  instance_type        = "ecs.e-c1m1.large"
  security_groups      = [alicloud_security_group.sg1.id]
  vswitch_id           = alicloud_vswitch.vsw1-1.id
  image_id             = "aliyun_3_x64_20G_qboot_alibase_20230727.vhd"
  system_disk_category = "cloud_essd"
  private_ip           = "10.0.0.1"
  ipv6_address_count   = 1
  instance_charge_type = "PostPaid"
  user_data = base64encode(<<-EOT
    #!/bin/bash
    echo ecs_ok > /root/ok.txt
    sudo acs-plugin-manager --exec --plugin=ecs-utils-ipv6
  EOT
  )
}

# --- ecs2 ---
resource "alicloud_instance" "ecs2" {
  provider             = alicloud.shanghai
  instance_name        = "${var.pname}-ecs2"
  instance_type        = "ecs.e-c1m1.large"
  security_groups      = [alicloud_security_group.sg2.id]
  vswitch_id           = alicloud_vswitch.vsw2-1.id
  image_id             = "aliyun_3_x64_20G_qboot_alibase_20230727.vhd"
  system_disk_category = "cloud_essd"
  private_ip           = "172.16.0.1"
  ipv6_address_count   = 1
  instance_charge_type = "PostPaid"
  user_data = base64encode(<<-EOT
    #!/bin/bash
    echo ecs_ok > /root/ok.txt
    sudo acs-plugin-manager --exec --plugin=ecs-utils-ipv6
  EOT
  )
}

# sg
resource "alicloud_security_group" "sg1" {
  provider = alicloud.hangzhou
  name     = "${var.pname}-sg1"
  vpc_id   = alicloud_vpc.vpc1.id
}
resource "alicloud_security_group_rule" "allow_inbound_ssh1" {
  provider          = alicloud.hangzhou
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.sg1.id
  cidr_ip           = "0.0.0.0/0"
}
resource "alicloud_security_group_rule" "allow_inbound_icmp1" {
  provider          = alicloud.hangzhou
  type              = "ingress"
  ip_protocol       = "icmp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.sg1.id
  cidr_ip           = "0.0.0.0/0"
}
resource "alicloud_security_group_rule" "allow_inbound_ipv6_icmp1" {
  provider          = alicloud.hangzhou
  type              = "ingress"
  ip_protocol       = "all"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.sg1.id
  ipv6_cidr_ip      = "::/0"
}

resource "alicloud_security_group" "sg2" {
  provider = alicloud.shanghai
  name     = "${var.pname}-sg2"
  vpc_id   = alicloud_vpc.vpc2.id
}
resource "alicloud_security_group_rule" "allow_inbound_ssh2" {
  provider          = alicloud.shanghai
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.sg2.id
  cidr_ip           = "0.0.0.0/0"
}
resource "alicloud_security_group_rule" "allow_inbound_icmp2" {
  provider          = alicloud.shanghai
  type              = "ingress"
  ip_protocol       = "icmp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.sg2.id
  cidr_ip           = "0.0.0.0/0"
}
resource "alicloud_security_group_rule" "allow_inbound_ipv6_icmp2" {
  provider = alicloud.shanghai

  type              = "ingress"
  ip_protocol       = "all"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.sg2.id
  ipv6_cidr_ip      = "::/0"
}


# --- cen and tr ---
resource "alicloud_cen_instance" "cen1" {
  cen_instance_name = "${var.pname}-cen1"
}
resource "alicloud_cen_transit_router" "tr1" {
  provider            = alicloud.hangzhou
  transit_router_name = "${var.pname}-tr1"
  cen_id              = alicloud_cen_instance.cen1.id
}
resource "alicloud_cen_transit_router" "tr2" {
  provider            = alicloud.shanghai
  transit_router_name = "${var.pname}-tr2"
  cen_id              = alicloud_cen_instance.cen1.id
}
# get tr sys table id
data "alicloud_cen_transit_router_route_tables" "tr1" { # get tr sys table
  transit_router_id               = alicloud_cen_transit_router.tr1.transit_router_id
  transit_router_route_table_type = "System"
}
data "alicloud_cen_transit_router_route_tables" "tr2" {
  transit_router_id               = alicloud_cen_transit_router.tr2.transit_router_id
  transit_router_route_table_type = "System"
}

# tr-peer
resource "alicloud_cen_transit_router_peer_attachment" "peer" {
  provider                      = alicloud.hangzhou
  cen_id                        = alicloud_cen_instance.cen1.id
  transit_router_id             = alicloud_cen_transit_router.tr1.transit_router_id
  peer_transit_router_region_id = var.shanghai_region_id
  peer_transit_router_id        = alicloud_cen_transit_router.tr2.transit_router_id
  bandwidth_type                = "DataTransfer"
  bandwidth                     = 1
  auto_publish_route_enabled    = true # default is false
}
resource "alicloud_cen_transit_router_route_table_association" "ass_peer1" {
  transit_router_route_table_id = data.alicloud_cen_transit_router_route_tables.tr1.tables[0].id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.peer.transit_router_attachment_id
}
resource "alicloud_cen_transit_router_route_table_propagation" "propa_peer1" {
  transit_router_route_table_id = data.alicloud_cen_transit_router_route_tables.tr1.tables[0].id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.peer.transit_router_attachment_id
}
resource "alicloud_cen_transit_router_route_table_association" "ass_peer2" {
  transit_router_route_table_id = data.alicloud_cen_transit_router_route_tables.tr2.tables[0].id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.peer.transit_router_attachment_id
}
resource "alicloud_cen_transit_router_route_table_propagation" "propa_peer2" {
  transit_router_route_table_id = data.alicloud_cen_transit_router_route_tables.tr2.tables[0].id
  transit_router_attachment_id  = alicloud_cen_transit_router_peer_attachment.peer.transit_router_attachment_id
}

# cidr_list
variable "cidr_list" {
  description = "The list of Private CIDR block"
  type        = list(string)
  default     = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

# attach1
resource "alicloud_cen_transit_router_vpc_attachment" "attach1" {
  provider          = alicloud.hangzhou
  cen_id            = alicloud_cen_instance.cen1.id
  transit_router_id = alicloud_cen_transit_router.tr1.transit_router_id
  vpc_id            = alicloud_vpc.vpc1.id
  zone_mappings {
    zone_id    = var.hangzhou_az_list[0]
    vswitch_id = alicloud_vswitch.vsw1-1.id
  }
  zone_mappings {
    zone_id    = var.hangzhou_az_list[1]
    vswitch_id = alicloud_vswitch.vsw1-2.id
  }
  transit_router_vpc_attachment_name    = "attach1"
  transit_router_vpc_attachment_options = { ipv6Support : "enable" }
  auto_publish_route_enabled            = true # default is false
}
resource "alicloud_cen_transit_router_route_table_association" "ass1" {
  transit_router_route_table_id = data.alicloud_cen_transit_router_route_tables.tr1.tables[0].id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.attach1.transit_router_attachment_id
}
resource "alicloud_cen_transit_router_route_table_propagation" "propa1" {
  transit_router_route_table_id = data.alicloud_cen_transit_router_route_tables.tr1.tables[0].id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.attach1.transit_router_attachment_id
}
resource "alicloud_route_entry" "vpc1_to_tr1" {
  provider              = alicloud.hangzhou
  count                 = 3
  route_table_id        = alicloud_vpc.vpc1.route_table_id
  destination_cidrblock = var.cidr_list[count.index]
  nexthop_type          = "Attachment"
  nexthop_id            = alicloud_cen_transit_router_vpc_attachment.attach1.transit_router_attachment_id
}

# attach2
resource "alicloud_cen_transit_router_vpc_attachment" "attach2" {
  provider          = alicloud.shanghai
  cen_id            = alicloud_cen_instance.cen1.id
  transit_router_id = alicloud_cen_transit_router.tr2.transit_router_id
  vpc_id            = alicloud_vpc.vpc2.id
  zone_mappings {
    zone_id    = var.shanghai_az_list[0]
    vswitch_id = alicloud_vswitch.vsw2-1.id
  }
  zone_mappings {
    zone_id    = var.shanghai_az_list[1]
    vswitch_id = alicloud_vswitch.vsw2-2.id
  }
  transit_router_vpc_attachment_name    = "attach2"
  transit_router_vpc_attachment_options = { ipv6Support : "enable" }
  auto_publish_route_enabled            = true # default is false
}
resource "alicloud_cen_transit_router_route_table_association" "ass2" {
  transit_router_route_table_id = data.alicloud_cen_transit_router_route_tables.tr2.tables[0].id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.attach2.transit_router_attachment_id
}
resource "alicloud_cen_transit_router_route_table_propagation" "propa2" {
  transit_router_route_table_id = data.alicloud_cen_transit_router_route_tables.tr2.tables[0].id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.attach2.transit_router_attachment_id
}
resource "alicloud_route_entry" "vpc2_to_tr2" {
  provider              = alicloud.shanghai
  count                 = 3
  route_table_id        = alicloud_vpc.vpc2.route_table_id
  destination_cidrblock = var.cidr_list[count.index]
  nexthop_type          = "Attachment"
  nexthop_id            = alicloud_cen_transit_router_vpc_attachment.attach2.transit_router_attachment_id
}

output "ecs1_login_address" {
  value = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${var.hangzhou_region_id}&instanceId=${alicloud_instance.ecs1.id}"
}

output "ecs2_login_address" {
  value = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${var.shanghai_region_id}&instanceId=${alicloud_instance.ecs2.id}"
}
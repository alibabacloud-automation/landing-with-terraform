variable "pname" {
  description = "The prefix name for the resources"
  type        = string
  default     = "tf-CenSec"
}

variable "default_region" {
  description = "Default region"
  type        = string
  default     = "cn-hangzhou"
}

variable "az" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["cn-hangzhou-i", "cn-hangzhou-j", "cn-hangzhou-k"]
}

variable "vpc_count" {
  description = "Number of VPCs to create"
  type        = number
  default     = 3
}

provider "alicloud" {
  region = var.default_region
}

# vpc
resource "alicloud_vpc" "main" {
  count      = var.vpc_count
  vpc_name   = "${var.pname}-vpc${count.index + 1}"
  cidr_block = "10.${count.index}.0.0/16"
}

# vsw
resource "alicloud_vswitch" "main" {
  count        = var.vpc_count * length(var.az)
  vpc_id       = alicloud_vpc.main[floor(count.index / length(var.az))].id
  cidr_block   = "10.${floor(count.index / length(var.az))}.${count.index % length(var.az)}.0/24"
  zone_id      = var.az[count.index % length(var.az)]
  vswitch_name = "${var.pname}-vsw${count.index + 1}"
}

# ecs
resource "alicloud_instance" "main" {
  count                = var.vpc_count
  instance_name        = "${var.pname}-ecs${count.index + 1}"
  instance_type        = "ecs.e-c1m1.large"
  security_groups      = [alicloud_security_group.main[count.index].id]
  vswitch_id           = alicloud_vswitch.main[count.index * length(var.az)].id
  image_id             = "aliyun_3_x64_20G_qboot_alibase_20230727.vhd"
  system_disk_category = "cloud_essd"
  private_ip           = "10.${count.index}.0.1"
  instance_charge_type = "PostPaid"
  user_data = base64encode(<<-EOT
    #!/bin/bash
    ${count.index == 0 ? "echo 1 > /proc/sys/net/ipv4/ip_forward" : ""} 
    yum install -y traceroute
    yum install -y mtr
  EOT
  ) # ecs1 enable ip_forward
}

# sg
resource "alicloud_security_group" "main" {
  count  = var.vpc_count
  name   = "${var.pname}-${count.index + 1}"
  vpc_id = alicloud_vpc.main[count.index].id
}

resource "alicloud_security_group_rule" "allow_inbound_ssh" {
  count             = var.vpc_count
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.main[count.index].id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_inbound_icmp" {
  count             = var.vpc_count
  type              = "ingress"
  ip_protocol       = "icmp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.main[count.index].id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_all_outbound" {
  count             = var.vpc_count
  type              = "egress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 1
  security_group_id = alicloud_security_group.main[count.index].id
  cidr_ip           = "0.0.0.0/0"
}

# cen
resource "alicloud_cen_instance" "cen1" {
  cen_instance_name = var.pname
}

# tr
resource "alicloud_cen_transit_router" "tr1" {
  transit_router_name = var.pname
  cen_id              = alicloud_cen_instance.cen1.id
}

# attach1  to vsw2 vsw3 in vpc1
resource "alicloud_cen_transit_router_vpc_attachment" "attach1" {
  cen_id            = alicloud_cen_instance.cen1.id
  transit_router_id = alicloud_cen_transit_router.tr1.transit_router_id
  vpc_id            = alicloud_vpc.main[0].id
  zone_mappings {
    zone_id    = var.az[1]
    vswitch_id = alicloud_vswitch.main[1].id # vsw2, vpc1-2
  }
  zone_mappings {
    zone_id    = var.az[2]
    vswitch_id = alicloud_vswitch.main[2].id # vsw3, vpc1-3
  }
  transit_router_vpc_attachment_name = "attach1"
}

# attach2 to vsw1 vsw2 in vpc2
resource "alicloud_cen_transit_router_vpc_attachment" "attach2" {
  cen_id            = alicloud_cen_instance.cen1.id
  transit_router_id = alicloud_cen_transit_router.tr1.transit_router_id
  vpc_id            = alicloud_vpc.main[1].id
  zone_mappings {
    zone_id    = var.az[0]
    vswitch_id = alicloud_vswitch.main[3].id # vsw4, vpc2-1
  }
  zone_mappings {
    zone_id    = var.az[1]
    vswitch_id = alicloud_vswitch.main[4].id # vsw5, vpc2-2
  }
  transit_router_vpc_attachment_name = "attach2"
}


# attach3 to vsw1 vsw2 in vpc3
resource "alicloud_cen_transit_router_vpc_attachment" "attach3" {
  cen_id            = alicloud_cen_instance.cen1.id
  transit_router_id = alicloud_cen_transit_router.tr1.transit_router_id
  vpc_id            = alicloud_vpc.main[2].id
  zone_mappings {
    zone_id    = var.az[0]
    vswitch_id = alicloud_vswitch.main[6].id # vsw6, vpc3-1
  }
  zone_mappings {
    zone_id    = var.az[1]
    vswitch_id = alicloud_vswitch.main[7].id # vsw7, vpc3-2
  }
  transit_router_vpc_attachment_name = "attach3"
}

# 3 rt for vpc1
resource "alicloud_route_table" "rt" {
  count            = 3
  vpc_id           = alicloud_vpc.main[0].id
  route_table_name = "${var.pname}-rt${count.index}"
  associate_type   = "VSwitch"
}

# 3 rt attach to vsw1 2 3  
resource "alicloud_route_table_attachment" "rt_attach" {
  count          = 3
  vswitch_id     = alicloud_vswitch.main[count.index].id
  route_table_id = alicloud_route_table.rt[count.index].id
}

# rt entry, vpc1
resource "alicloud_route_entry" "rt-entry1" { # nexthop tr
  route_table_id        = alicloud_route_table.rt[0].id
  destination_cidrblock = "0.0.0.0/0"
  nexthop_type          = "Attachment"
  nexthop_id            = alicloud_cen_transit_router_vpc_attachment.attach1.transit_router_attachment_id
}
resource "alicloud_route_entry" "rt-entry2" { # nexthop ecs1
  route_table_id        = alicloud_route_table.rt[1].id
  destination_cidrblock = "0.0.0.0/0"
  nexthop_type          = "Instance"
  nexthop_id            = alicloud_instance.main[0].id # ecs1
}
resource "alicloud_route_entry" "rt-entry3" { # nexthop ecs1
  route_table_id        = alicloud_route_table.rt[2].id
  destination_cidrblock = "0.0.0.0/0"
  nexthop_type          = "Instance"
  nexthop_id            = alicloud_instance.main[0].id # ecs1
}

# rt entry, vpc2 vpc3
resource "alicloud_route_entry" "rt-entry4" {
  route_table_id        = alicloud_vpc.main[1].route_table_id
  destination_cidrblock = "0.0.0.0/0"
  nexthop_type          = "Attachment"
  nexthop_id            = alicloud_cen_transit_router_vpc_attachment.attach2.transit_router_attachment_id
}
resource "alicloud_route_entry" "rt-entry5" {
  route_table_id        = alicloud_vpc.main[2].route_table_id
  destination_cidrblock = "0.0.0.0/0"
  nexthop_type          = "Attachment"
  nexthop_id            = alicloud_cen_transit_router_vpc_attachment.attach3.transit_router_attachment_id
}

# new 2 tr_rt
resource "alicloud_cen_transit_router_route_table" "tr_rt1" {
  transit_router_id               = alicloud_cen_transit_router.tr1.transit_router_id
  transit_router_route_table_name = "tr_rt1"
}

resource "alicloud_cen_transit_router_route_table" "tr_rt2" {
  transit_router_id               = alicloud_cen_transit_router.tr1.transit_router_id
  transit_router_route_table_name = "tr_rt2"
}

# ass rt1 attach2 3
resource "alicloud_cen_transit_router_route_table_association" "ass1" {
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr_rt1.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.attach2.transit_router_attachment_id
}
resource "alicloud_cen_transit_router_route_table_association" "ass2" {
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr_rt1.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.attach3.transit_router_attachment_id
}
# ass rt2 attach1
resource "alicloud_cen_transit_router_route_table_association" "ass3" {
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.tr_rt2.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.attach1.transit_router_attachment_id
}

# tr_rt_entry
resource "alicloud_cen_transit_router_route_entry" "tr_rt1_entry1" {
  transit_router_route_table_id                     = alicloud_cen_transit_router_route_table.tr_rt1.transit_router_route_table_id
  transit_router_route_entry_destination_cidr_block = "0.0.0.0/0"
  transit_router_route_entry_next_hop_type          = "Attachment"
  transit_router_route_entry_next_hop_id            = alicloud_cen_transit_router_vpc_attachment.attach1.transit_router_attachment_id
}
resource "alicloud_cen_transit_router_route_entry" "tr_rt2_entry1" {
  transit_router_route_table_id                     = alicloud_cen_transit_router_route_table.tr_rt2.transit_router_route_table_id
  transit_router_route_entry_destination_cidr_block = "10.1.0.0/16"
  transit_router_route_entry_next_hop_type          = "Attachment"
  transit_router_route_entry_next_hop_id            = alicloud_cen_transit_router_vpc_attachment.attach2.transit_router_attachment_id
}
resource "alicloud_cen_transit_router_route_entry" "tr_rt2_entry2" {
  transit_router_route_table_id                     = alicloud_cen_transit_router_route_table.tr_rt2.transit_router_route_table_id
  transit_router_route_entry_destination_cidr_block = "10.2.0.0/16"
  transit_router_route_entry_next_hop_type          = "Attachment"
  transit_router_route_entry_next_hop_id            = alicloud_cen_transit_router_vpc_attachment.attach3.transit_router_attachment_id
}

output "ecs1_login_address" {
  value = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${var.default_region}&instanceId=${alicloud_instance.main[0].id}"
}

output "ecs2_login_address" {
  value = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${var.default_region}&instanceId=${alicloud_instance.main[1].id}"
}

output "ecs3_login_address" {
  value = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${var.default_region}&instanceId=${alicloud_instance.main[2].id}"
}
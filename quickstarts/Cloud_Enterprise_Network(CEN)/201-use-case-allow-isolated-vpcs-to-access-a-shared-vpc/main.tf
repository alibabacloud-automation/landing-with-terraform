variable "pname" {
  description = "The prefix name for the resources"
  type        = string
  default     = "tf-CenSharedVpc"
}

variable "default_region" {
  description = "Default region"
  type        = string
  default     = "cn-hangzhou"
}

variable "az_list" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["cn-hangzhou-j", "cn-hangzhou-k"]
}

variable "vpc_cidr_list" {
  description = "List of VPC CIDR block"
  type        = list(string)
  default     = ["192.168.0.0/16", "172.16.0.0/12", "10.0.0.0/16"]
}

variable "vsw_cidr_list" {
  description = "List of VSW CIDR block"
  type        = list(string)
  default = [
    "192.168.0.0/24", "192.168.1.0/24",
    "172.16.0.0/24", "172.16.1.0/24",
    "10.0.0.0/24", "10.0.1.0/24"
  ]
}

variable "ecs_ip_list" {
  description = "List of ECS ip"
  type        = list(string)
  default     = ["192.168.0.124", "172.16.0.222", "10.0.0.112"]
}

provider "alicloud" {
  region = var.default_region
}

# --- 3vpc 6vsw 3ecs
resource "alicloud_vpc" "vpc" {
  count      = length(var.vpc_cidr_list)
  vpc_name   = "${var.pname}-vpc${count.index + 1}"
  cidr_block = var.vpc_cidr_list[count.index]
}

resource "alicloud_vswitch" "vsw" {
  count        = length(var.vsw_cidr_list)
  vpc_id       = alicloud_vpc.vpc[floor(count.index / length(var.az_list))].id
  cidr_block   = var.vsw_cidr_list[count.index]
  zone_id      = var.az_list[count.index % length(var.az_list)]
  vswitch_name = "${var.pname}-vsw${count.index + 1}"
}

resource "alicloud_instance" "ecs" {
  count                = length(var.vpc_cidr_list)
  instance_name        = "${var.pname}-ecs${count.index + 1}"
  instance_type        = "ecs.e-c1m1.large"
  security_groups      = [alicloud_security_group.sg[count.index].id]
  vswitch_id           = alicloud_vswitch.vsw[count.index * length(var.az_list)].id
  image_id             = "aliyun_3_x64_20G_qboot_alibase_20230727.vhd"
  system_disk_category = "cloud_essd"
  private_ip           = var.ecs_ip_list[count.index]
  instance_charge_type = "PostPaid"
}

# --- 3 sg
resource "alicloud_security_group" "sg" {
  count  = length(var.vpc_cidr_list)
  name   = "${var.pname}-${count.index + 1}"
  vpc_id = alicloud_vpc.vpc[count.index].id
}

resource "alicloud_security_group_rule" "allow_inbound_ssh" {
  count             = length(var.vpc_cidr_list)
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.sg[count.index].id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_inbound_icmp" {
  count             = length(var.vpc_cidr_list)
  type              = "ingress"
  ip_protocol       = "icmp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.sg[count.index].id
  cidr_ip           = "0.0.0.0/0"
}

# --- cen and tr
resource "alicloud_cen_instance" "cen" {
  cen_instance_name = "${var.pname}-cen1"
}
resource "alicloud_cen_transit_router" "tr" {
  transit_router_name = "${var.pname}-tr"
  cen_id              = alicloud_cen_instance.cen.id
}
data "alicloud_cen_transit_router_route_tables" "tr" { # get tr sys table
  transit_router_id               = alicloud_cen_transit_router.tr.transit_router_id
  transit_router_route_table_type = "System"
}

# 3 attach
resource "alicloud_cen_transit_router_vpc_attachment" "attach" {
  count             = length(var.vpc_cidr_list)
  cen_id            = alicloud_cen_instance.cen.id
  transit_router_id = alicloud_cen_transit_router.tr.transit_router_id
  vpc_id            = alicloud_vpc.vpc[count.index].id
  zone_mappings {
    zone_id    = var.az_list[0]
    vswitch_id = alicloud_vswitch.vsw[count.index * length(var.az_list)].id
  }
  zone_mappings {
    zone_id    = var.az_list[1]
    vswitch_id = alicloud_vswitch.vsw[count.index * length(var.az_list) + 1].id
  }
  transit_router_vpc_attachment_name = "attach${count.index + 1}"
}

# 3 propa
resource "alicloud_cen_transit_router_route_table_propagation" "propa" {
  count                         = length(var.vpc_cidr_list)
  transit_router_route_table_id = data.alicloud_cen_transit_router_route_tables.tr.tables[0].id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.attach[count.index].transit_router_attachment_id
}

# 1 custom_table
resource "alicloud_cen_transit_router_route_table" "custom_table" { # create tr custom_table
  transit_router_id               = alicloud_cen_transit_router.tr.transit_router_id
  transit_router_route_table_name = "custom_table"
}

resource "alicloud_cen_transit_router_route_entry" "tr_entry" {
  transit_router_route_table_id                     = alicloud_cen_transit_router_route_table.custom_table.transit_router_route_table_id
  transit_router_route_entry_destination_cidr_block = "10.0.0.0/16"
  transit_router_route_entry_next_hop_type          = "Attachment"
  transit_router_route_entry_name                   = "entry1_name"
  transit_router_route_entry_description            = "entry1_desc"
  transit_router_route_entry_next_hop_id            = alicloud_cen_transit_router_vpc_attachment.attach[2].transit_router_attachment_id
}

# associate attach1\2   custom_table
resource "alicloud_cen_transit_router_route_table_association" "ass1" {
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.custom_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.attach[0].transit_router_attachment_id
}
resource "alicloud_cen_transit_router_route_table_association" "ass2" {
  transit_router_route_table_id = alicloud_cen_transit_router_route_table.custom_table.transit_router_route_table_id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.attach[1].transit_router_attachment_id
}
# ass attach3 sys_table
resource "alicloud_cen_transit_router_route_table_association" "ass3" {
  transit_router_route_table_id = data.alicloud_cen_transit_router_route_tables.tr.tables[0].id
  transit_router_attachment_id  = alicloud_cen_transit_router_vpc_attachment.attach[2].transit_router_attachment_id
}

# vpc entry
resource "alicloud_route_entry" "vpc_entry" {
  count                 = length(var.vpc_cidr_list)
  route_table_id        = alicloud_vpc.vpc[count.index].route_table_id
  destination_cidrblock = "0.0.0.0/0"
  nexthop_type          = "Attachment"
  nexthop_id            = alicloud_cen_transit_router_vpc_attachment.attach[count.index].transit_router_attachment_id
}

output "ecs1_login_address" {
  value = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${var.default_region}&instanceId=${alicloud_instance.ecs[0].id}"
}

output "ecs2_login_address" {
  value = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${var.default_region}&instanceId=${alicloud_instance.ecs[1].id}"
}

output "ecs3_login_address" {
  value = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${var.default_region}&instanceId=${alicloud_instance.ecs[2].id}"
}
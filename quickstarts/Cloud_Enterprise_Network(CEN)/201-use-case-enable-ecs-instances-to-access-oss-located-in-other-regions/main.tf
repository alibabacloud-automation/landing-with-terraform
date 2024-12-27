variable "pname" {
  description = "The prefix name for resources"
  type        = string
  default     = "tf-cen-oss"
}

variable "region_id_hangzhou" {
  description = "The region id of hangzhou"
  type        = string
  default     = "cn-hangzhou"
}

variable "region_id_shanghai" { #
  description = "The region id of shanghai"
  type        = string
  default     = "cn-shanghai"
}

variable "az_hangzhou" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["cn-hangzhou-j", "cn-hangzhou-k"]
}

variable "az_shanghai" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["cn-shanghai-m", "cn-shanghai-n"]
}

variable "cidr_list" {
  description = "List of VPC CIDR block"
  type        = list(string)
  default     = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

# --- provider ---
provider "alicloud" { # default region hangzhou
  region = var.region_id_hangzhou
}

provider "alicloud" {
  alias  = "hangzhou"
  region = var.region_id_hangzhou
}

provider "alicloud" {
  alias  = "shanghai"
  region = var.region_id_shanghai
}

# ---  oss ---
resource "random_uuid" "default" {
}
resource "alicloud_oss_bucket" "bucket1" {
  provider = alicloud.hangzhou
  bucket   = substr("${var.pname}-${replace(random_uuid.default.result, "-", "")}", 0, 32)
  lifecycle {
    ignore_changes = [
      policy,
    ]
  }
}

resource "alicloud_oss_bucket_policy" "default" {
  provider = alicloud.hangzhou
  policy   = jsonencode({ "Version" : "1", "Statement" : [{ "Action" : ["oss:GetObject"], "Effect" : "Allow", "Resource" : ["acs:oss:*:*:${alicloud_oss_bucket.bucket1.bucket}"] }] })
  bucket   = alicloud_oss_bucket.bucket1.bucket
}

resource "alicloud_oss_bucket_object" "obj1" {
  provider = alicloud.hangzhou
  bucket   = alicloud_oss_bucket.bucket1.bucket
  key      = "example.txt"                     # Name of the file in the bucket
  content  = "this is example text content \n" # Content of the file
  acl      = "public-read"
}

# --- vpc ---
resource "alicloud_vpc" "vpc1" {
  provider   = alicloud.shanghai
  vpc_name   = "${var.pname}-1"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vpc" "vpc2" {
  provider   = alicloud.hangzhou
  vpc_name   = "${var.pname}-2"
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "vsw1-1" {
  provider     = alicloud.shanghai
  vpc_id       = alicloud_vpc.vpc1.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = var.az_shanghai[0]
  vswitch_name = "${var.pname}-vsw1-1"
}
resource "alicloud_vswitch" "vsw1-2" {
  provider     = alicloud.shanghai
  vpc_id       = alicloud_vpc.vpc1.id
  cidr_block   = "192.168.1.0/24"
  zone_id      = var.az_shanghai[1]
  vswitch_name = "${var.pname}-vsw1-2"
}
resource "alicloud_vswitch" "vsw2-1" {
  provider     = alicloud.hangzhou
  vpc_id       = alicloud_vpc.vpc2.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = var.az_hangzhou[0]
  vswitch_name = "${var.pname}-vsw2-1"
}
resource "alicloud_vswitch" "vsw2-2" {
  provider     = alicloud.hangzhou
  vpc_id       = alicloud_vpc.vpc2.id
  cidr_block   = "172.16.1.0/24"
  zone_id      = var.az_hangzhou[1]
  vswitch_name = "${var.pname}-vsw2-2"
}

# --- cen ---
# cen
resource "alicloud_cen_instance" "cen1" {
  cen_instance_name = "${var.pname}-cen1"
}

# tr
resource "alicloud_cen_transit_router" "tr1" {
  provider            = alicloud.shanghai
  transit_router_name = "${var.pname}-tr1"
  cen_id              = alicloud_cen_instance.cen1.id
}
resource "alicloud_cen_transit_router" "tr2" {
  provider            = alicloud.hangzhou
  transit_router_name = "${var.pname}-tr2"
  cen_id              = alicloud_cen_instance.cen1.id
}
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
  provider                      = alicloud.shanghai
  cen_id                        = alicloud_cen_instance.cen1.id
  transit_router_id             = alicloud_cen_transit_router.tr1.transit_router_id
  peer_transit_router_region_id = var.region_id_hangzhou
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

# attach1  
resource "alicloud_cen_transit_router_vpc_attachment" "attach1" {
  provider          = alicloud.shanghai
  cen_id            = alicloud_cen_instance.cen1.id
  transit_router_id = alicloud_cen_transit_router.tr1.transit_router_id
  vpc_id            = alicloud_vpc.vpc1.id
  zone_mappings {
    zone_id    = var.az_shanghai[0]
    vswitch_id = alicloud_vswitch.vsw1-1.id
  }
  zone_mappings {
    zone_id    = var.az_shanghai[1]
    vswitch_id = alicloud_vswitch.vsw1-2.id
  }
  transit_router_vpc_attachment_name = "attach1"
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
  provider              = alicloud.shanghai
  count                 = 3
  route_table_id        = alicloud_vpc.vpc1.route_table_id
  destination_cidrblock = var.cidr_list[count.index]
  nexthop_type          = "Attachment"
  nexthop_id            = alicloud_cen_transit_router_vpc_attachment.attach1.transit_router_attachment_id
}

# attach2
resource "alicloud_cen_transit_router_vpc_attachment" "attach2" {
  provider          = alicloud.hangzhou
  cen_id            = alicloud_cen_instance.cen1.id
  transit_router_id = alicloud_cen_transit_router.tr2.transit_router_id
  vpc_id            = alicloud_vpc.vpc2.id
  zone_mappings {
    zone_id    = var.az_hangzhou[0]
    vswitch_id = alicloud_vswitch.vsw2-1.id
  }
  zone_mappings {
    zone_id    = var.az_hangzhou[1]
    vswitch_id = alicloud_vswitch.vsw2-2.id
  }
  transit_router_vpc_attachment_name = "attach2"
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
  provider              = alicloud.hangzhou
  count                 = 3
  route_table_id        = alicloud_vpc.vpc2.route_table_id
  destination_cidrblock = var.cidr_list[count.index]
  nexthop_type          = "Attachment"
  nexthop_id            = alicloud_cen_transit_router_vpc_attachment.attach2.transit_router_attachment_id
}

# oss_cidr
variable "oss_cidr" {
  description = "The OSS CIDR block"
  type        = list(string)
  default     = ["100.118.28.0/24", "100.114.102.0/24", "100.98.170.0/24", "100.118.31.0/24"]
}

# vpc entry
resource "alicloud_route_entry" "entry" {
  provider              = alicloud.shanghai
  count                 = 4
  route_table_id        = alicloud_vpc.vpc1.route_table_id
  destination_cidrblock = var.oss_cidr[count.index]
  nexthop_type          = "Attachment"
  nexthop_id            = alicloud_cen_transit_router_vpc_attachment.attach1.transit_router_attachment_id
}

# tr entry 
resource "alicloud_cen_transit_router_route_entry" "tr2_rt1_entry1" {
  count                                             = 4
  transit_router_route_table_id                     = data.alicloud_cen_transit_router_route_tables.tr2.tables[0].id
  transit_router_route_entry_destination_cidr_block = var.oss_cidr[count.index]
  transit_router_route_entry_next_hop_type          = "Attachment"
  transit_router_route_entry_next_hop_id            = alicloud_cen_transit_router_vpc_attachment.attach2.transit_router_attachment_id
}

# --- ecs ---
resource "alicloud_instance" "main" {
  provider             = alicloud.shanghai
  depends_on           = [alicloud_cen_transit_router_route_entry.tr2_rt1_entry1]
  instance_name        = "${var.pname}-ecs"
  instance_type        = "ecs.e-c1m1.large"
  security_groups      = [alicloud_security_group.default.id]
  vswitch_id           = alicloud_vswitch.vsw1-1.id
  image_id             = "aliyun_3_x64_20G_qboot_alibase_20230727.vhd"
  system_disk_category = "cloud_essd"
  private_ip           = "192.168.0.1"
  instance_charge_type = "PostPaid"
  user_data = base64encode(<<-EOT
    #!/bin/bash
    curl  https://${alicloud_oss_bucket.bucket1.bucket}.${alicloud_oss_bucket.bucket1.intranet_endpoint}/${alicloud_oss_bucket_object.obj1.key}  > /root/curl.txt
  EOT
  )
}

# sg
resource "alicloud_security_group" "default" {
  provider = alicloud.shanghai
  name     = var.pname
  vpc_id   = alicloud_vpc.vpc1.id
}

resource "alicloud_security_group_rule" "allow_inbound_ssh" {
  provider          = alicloud.shanghai
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_inbound_icmp" {
  provider          = alicloud.shanghai
  type              = "ingress"
  ip_protocol       = "icmp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = "0.0.0.0/0"
}

# --- output ---
output "ecs_login_address" {
  value = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${var.region_id_shanghai}&instanceId=${alicloud_instance.main.id}"
}

output "test_command" {
  value = "curl ${alicloud_oss_bucket.bucket1.bucket}.${alicloud_oss_bucket.bucket1.intranet_endpoint}/${alicloud_oss_bucket_object.obj1.key}"
}
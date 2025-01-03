// VPC NAT 网关有默认的 NAT IP；  公网NAT实例 绑定的是EIP
variable "region" {
  default = "cn-beijing"
}
provider "alicloud" {
  region = var.region
}
variable "name" {
  default = "nat-test"
}
variable "password" {
  default = "Test123@"
}
// 查询ECS镜像
data "alicloud_images" "default" {
  most_recent = true
  owners      = "system"
}
// 查询ECS类型
data "alicloud_instance_types" "default" {
  availability_zone = data.alicloud_zones.default.zones.0.id
  image_id          = data.alicloud_images.default.images.0.id
}
// 查询 ECS 可用区
data "alicloud_zones" "default" {
}
// 查询 NAT 网关 A 的 NAT IP
data "alicloud_vpc_nat_ips" "nat_ips_a" {
  nat_gateway_id = alicloud_nat_gateway.a.id
}
// 查询 NAT 网关 B 的 NAT IP
data "alicloud_vpc_nat_ips" "nat_ips_b" {
  nat_gateway_id = alicloud_nat_gateway.b.id
}
locals {
  master_zone = "cn-beijing-h"
  slave_zone  = "cn-beijing-k"
  image_id    = "aliyun_3_x64_20G_alibase_20241103.vhd"
  // 筛选出默认的 NAT IP
  default_nat_ip_a = [for ip in data.alicloud_vpc_nat_ips.nat_ips_a.ips : ip if ip.is_default][0]
  default_nat_ip_b = [for ip in data.alicloud_vpc_nat_ips.nat_ips_b.ips : ip if ip.is_default][0]
}
// 查询CEN实例中创建的转发路由器系统路由表ID
data "alicloud_cen_transit_router_route_tables" "cen_route_table_id" {
  transit_router_id               = alicloud_cen_transit_router.example.transit_router_id
  transit_router_route_table_type = "System"
}
// 步骤一(准备前置资源)：分别为VPC_A、VPC_B添加附加网段并创建交换机，创建用于验证的 ECS_A ECS_B实例
// 创建 VPC_A 主网段
resource "alicloud_vpc" "a" {
  vpc_name   = "VPC_A"
  cidr_block = "192.168.0.0/16"
}
// 创建 VPC_A 的附加网段
resource "alicloud_vpc_ipv4_cidr_block" "a" {
  secondary_cidr_block = "172.16.0.0/12"
  vpc_id               = alicloud_vpc.a.id
}
// 创建Vswitch_A1 CIDR 块为 192.168.10.0/24
resource "alicloud_vswitch" "a1" {
  vpc_id       = alicloud_vpc.a.id
  cidr_block   = "192.168.10.0/24"
  zone_id      = local.master_zone
  vswitch_name = "VS_A1"
}
// 创建Vswitch_A2 CIDR 块为 172.16.20.0/24
resource "alicloud_vswitch" "a2" {
  vpc_id       = alicloud_vpc_ipv4_cidr_block.a.vpc_id
  cidr_block   = "172.16.20.0/24"
  zone_id      = local.slave_zone
  vswitch_name = "VS_A2"
}
// 创建 VPC_B 主网段
resource "alicloud_vpc" "b" {
  vpc_name   = "VPC_B"
  cidr_block = "192.168.0.0/16"
}
// 创建 VPC_B 的附加网段  10.0.0.0/8
resource "alicloud_vpc_ipv4_cidr_block" "b" {
  secondary_cidr_block = "10.0.0.0/8"
  vpc_id               = alicloud_vpc.b.id
}
// 创建Vswitch_B1 CIDR 块为 192.168.10.0/24
resource "alicloud_vswitch" "b1" {
  vpc_id       = alicloud_vpc.b.id
  cidr_block   = "192.168.10.0/24"
  zone_id      = local.master_zone
  vswitch_name = "VS_B1"
}
// 创建Vswitch_B2 CIDR 块为 10.0.20.0/24
resource "alicloud_vswitch" "b2" {
  vpc_id       = alicloud_vpc_ipv4_cidr_block.b.vpc_id
  cidr_block   = "10.0.20.0/24"
  zone_id      = local.slave_zone
  vswitch_name = "VS_B2"
}
// 安全组 VPC_A
resource "alicloud_security_group" "a" {
  security_group_name = "security_group_A"
  vpc_id              = alicloud_vpc.a.id
}
// 安全组 VPC_A 规则
resource "alicloud_security_group_rule" "a" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 1
  security_group_id = alicloud_security_group.a.id
  cidr_ip           = "0.0.0.0/0"
}
// 安全组 VPC_B
resource "alicloud_security_group" "b" {
  security_group_name = "security_group_B"
  vpc_id              = alicloud_vpc.b.id
}
// 安全组 VPC_B 规则
resource "alicloud_security_group_rule" "b" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 1
  security_group_id = alicloud_security_group.b.id
  cidr_ip           = "0.0.0.0/0"
}
// 创建ECS_A
resource "alicloud_instance" "a" {
  # 实例镜像
  // image_id                   = data.alicloud_images.default.images.0.id
  image_id = local.image_id
  # 启动类型
  instance_type = data.alicloud_instance_types.default.instance_types.0.id
  # 安全组
  security_groups = alicloud_security_group.a.*.id
  # 实例的互联网收费类型
  internet_charge_type = "PayByTraffic"
  # 向公共网络的最大出站带宽，以 Mbps（兆位每秒）为单位。值范围：[0，100]。 0不创建公网IP
  internet_max_bandwidth_out = "0"
  # 启动实例的可用区
  // availability_zone          = data.alicloud_instance_types.default.instance_types.0.availability_zones.0
  availability_zone = local.master_zone
  # 有效值为 PrePaid、PostPaid，默认值为 PostPaid。
  instance_charge_type = "PostPaid"
  # 仅对一些非 I/O 优化实例使用。
  system_disk_category = "cloud_efficiency"
  # 交换机id
  vswitch_id = alicloud_vswitch.a1.id
  # 实例名称
  instance_name = "ECS_A"
  # vpc-A ID
  vpc_id = alicloud_vpc.a.id
  # 密码
  password = var.password
}
// 创建ECS_B
resource "alicloud_instance" "b" {
  # 实例镜像
  // image_id                   = data.alicloud_images.default.images.0.id
  image_id = local.image_id
  # 启动类型
  instance_type = data.alicloud_instance_types.default.instance_types.0.id
  # 安全组
  security_groups = alicloud_security_group.b.*.id
  # 实例的互联网收费类型
  internet_charge_type = "PayByTraffic"
  # 向公共网络的最大出站带宽，以 Mbps（兆位每秒）为单位。值范围：[0，100]。 不创建公网IP
  internet_max_bandwidth_out = "0"
  # 启动实例的可用区
  // availability_zone          = data.alicloud_instance_types.default.instance_types.0.availability_zones.0
  availability_zone = local.master_zone
  # 有效值为 PrePaid、PostPaid，默认值为 PostPaid。
  instance_charge_type = "PostPaid"
  # 仅对一些非 I/O 优化实例使用。
  system_disk_category = "cloud_efficiency"
  # 交换机id
  vswitch_id = alicloud_vswitch.b1.id
  # 实例名称
  instance_name = "ECS_B"
  # vpc-A ID
  vpc_id = alicloud_vpc.b.id
  # 密码
  password = var.password
}
// 步骤二：分别为VPC_A、VPC_B创建VPC连接，以实现VPC_A访问VPC_B。
// 创建云企业网实例
resource "alicloud_cen_instance" "example" {
  # CEN实例名称
  cen_instance_name = var.name
  # 描述
  description = var.name
}
// 创建 传输路由器/转发路由器
resource "alicloud_cen_transit_router" "example" {
  # CEN实例 ID
  cen_id              = alicloud_cen_instance.example.id
  transit_router_name = var.name
}
// 创建转发路由器 VPC 附加资源,将 VPC_A 连接到 转发路由器
resource "alicloud_cen_transit_router_vpc_attachment" "a" {
  # CEN实例 ID
  cen_id = alicloud_cen_instance.example.id
  # 转发路由器 ID
  transit_router_id = alicloud_cen_transit_router.example.transit_router_id
  vpc_id            = alicloud_vpc.a.id
  # 指定是否启用企业版传输路由器自动广告路由到VPC
  auto_publish_route_enabled = true
  # 交换机
  zone_mappings {
    zone_id    = local.master_zone
    vswitch_id = alicloud_vswitch.a1.id
  }
  zone_mappings {
    zone_id    = local.slave_zone
    vswitch_id = alicloud_vswitch.a2.id
  }
  # 是否强制删除
  force_delete                          = true
  transit_router_vpc_attachment_name    = var.name
  transit_router_attachment_description = var.name
}
// 创建转发路由器 VPC 附加资源,将 VPC_B 连接到 转发路由器
resource "alicloud_cen_transit_router_vpc_attachment" "b" {
  # CEN实例 ID
  cen_id = alicloud_cen_instance.example.id
  # 转发路由器 ID
  transit_router_id = alicloud_cen_transit_router.example.transit_router_id
  vpc_id            = alicloud_vpc.b.id
  # 指定是否启用企业版传输路由器自动广告路由到VPC
  auto_publish_route_enabled = true
  # 交换机
  zone_mappings {
    zone_id    = local.master_zone
    vswitch_id = alicloud_vswitch.b1.id
  }
  zone_mappings {
    zone_id    = local.slave_zone
    vswitch_id = alicloud_vswitch.b2.id
  }
  # 是否强制删除
  force_delete                          = true
  transit_router_vpc_attachment_name    = var.name
  transit_router_attachment_description = var.name
}
// CEN 传输路由器路由表 VPC_A  自动学习路由条目
resource "alicloud_cen_transit_router_route_table_association" "a" {
  # 传输路由器路由表的ID。
  transit_router_route_table_id = data.alicloud_cen_transit_router_route_tables.cen_route_table_id.tables[0].transit_router_route_table_id
  # 传输路由器附件的ID。
  transit_router_attachment_id = alicloud_cen_transit_router_vpc_attachment.a.transit_router_attachment_id
}
// CEN 传输路由器路由表 VPC_B  自动学习路由条目
resource "alicloud_cen_transit_router_route_table_association" "b" {
  # 传输路由器路由表的ID。
  transit_router_route_table_id = data.alicloud_cen_transit_router_route_tables.cen_route_table_id.tables[0].transit_router_route_table_id
  # 传输路由器附件的ID。
  transit_router_attachment_id = alicloud_cen_transit_router_vpc_attachment.b.transit_router_attachment_id
}
// CEN传输路由器路由表传播 VPC_A 开启关联转发
resource "alicloud_cen_transit_router_route_table_propagation" "a" {
  # 传输路由器路由表的ID。
  transit_router_route_table_id = data.alicloud_cen_transit_router_route_tables.cen_route_table_id.tables[0].transit_router_route_table_id
  # 传输路由器附件的ID。
  transit_router_attachment_id = alicloud_cen_transit_router_vpc_attachment.a.transit_router_attachment_id
}
// CEN传输路由器路由表传播 VPC_B 开启关联转发
resource "alicloud_cen_transit_router_route_table_propagation" "b" {
  # 传输路由器路由表的ID。
  transit_router_route_table_id = data.alicloud_cen_transit_router_route_tables.cen_route_table_id.tables[0].transit_router_route_table_id
  # 传输路由器附件的ID。
  transit_router_attachment_id = alicloud_cen_transit_router_vpc_attachment.b.transit_router_attachment_id
}
// 步骤三：分别为VPC_A、VPC_B创建VPC NAT网关。为VPC_A创建SNAT条目;为ECS_B创建DNAT条目
// 为VPC_A 创建 VPC NAT 网关
resource "alicloud_nat_gateway" "a" {
  vpc_id           = alicloud_vpc.a.id
  nat_gateway_name = "nat_gateway_A"
  vswitch_id       = alicloud_vswitch.a2.id
  # 增强型
  nat_type = "Enhanced"
  # 是否强制删除
  force = true
  # 计费类型
  payment_type = "PayAsYouGo"
  # 网关类型 internet和intranet。internet: 互联网NAT网关。intranet: VPC NAT网关。
  network_type = "intranet"
  # 是否启用删除保护。默认值：false。
  deletion_protection = false
}
// 为VPC_B 创建 VPC NAT 网关
resource "alicloud_nat_gateway" "b" {
  vpc_id           = alicloud_vpc.b.id
  nat_gateway_name = "nat_gateway_B"
  # 交换机 a2
  vswitch_id = alicloud_vswitch.b2.id
  # 增强型
  nat_type = "Enhanced"
  # 是否强制删除
  force = true
  # 计费类型
  payment_type = "PayAsYouGo"
  # 网关类型 internet和intranet。internet: 互联网NAT网关。intranet: VPC NAT网关。
  network_type = "intranet"
  # 是否启用删除保护。默认值：false。
  deletion_protection = false
}
// 为 VPC_A 在 VPC_NAT_A 实例中配置 SNAT 条目
resource "alicloud_snat_entry" "default" {
  snat_entry_name = var.name
  # 该值可以从alicloud_nat_gateway的属性"snat_table_ids"获取。
  snat_table_id = alicloud_nat_gateway.a.snat_table_ids
  # 绑定交换机 a1
  source_vswitch_id = alicloud_vswitch.a1.id
  # SNAT的IP地址，IP必须与alicloud_nat_gateway参数bandwidth_packages中的带宽包公共IP一致。网关默认的NAT IP
  snat_ip = local.default_nat_ip_a.nat_ip
}
// 为 ECS_B 在 VPC NAT_B 实例中配置 DNAT 条目
resource "alicloud_forward_entry" "default" {
  # 该值可以从alicloud_nat_gateway的属性"forward_table_ids"获取
  forward_table_id = alicloud_nat_gateway.b.forward_table_ids
  # 外部IP地址，必须与alicloud_nat_gateway参数中的带宽包公共IP一致。 NAT IP
  external_ip = local.default_nat_ip_b.nat_ip
  # 外部端口，有效值为1~65535或其他。
  external_port = "22"
  # IP协议，有效值为tcp、udp或其他。
  ip_protocol = "tcp"
  # 内部IP，必须是私有IP。ECS_B 的私有ip 
  internal_ip = alicloud_instance.b.private_ip
  # 内部端口，有效值为1~65535或其他。
  internal_port = "22"
}
// 步骤四：分别为VPC_A、VPC_B创建自定义路由表。分别将vSwitch_A1、vSwitch_B1绑定至自定义路由表。
// 创建一个自定义路由表 VPC_A
resource "alicloud_route_table" "a" {
  vpc_id           = alicloud_vpc.a.id
  route_table_name = "custom-route-table-A"
}
// 将自定义路由表绑定到子网（交换机） VS_A
resource "alicloud_route_table_attachment" "a" {
  route_table_id = alicloud_route_table.a.id
  vswitch_id     = alicloud_vswitch.a1.id
}
// 创建一个自定义路由表 VPC_B
resource "alicloud_route_table" "b" {
  vpc_id           = alicloud_vpc.b.id
  route_table_name = "custom-route-table-B"
}
// 将自定义路由表绑定到子网（交换机） VS_B
resource "alicloud_route_table_attachment" "b" {
  route_table_id = alicloud_route_table.b.id
  vswitch_id     = alicloud_vswitch.b1.id
}
// 步骤五：分别为VPC_A、VPC_B的系统路由表配置路由条目。下一跳为 转发路由器
// 5.1 配置系统路由表 路由条目 VPC_A
resource "alicloud_route_entry" "a" {
  # 系统路由表id
  route_table_id = alicloud_vpc.a.route_table_id
  # 目标网段
  destination_cidrblock = "10.0.20.0/24"
  # 下一跳类型 传输路由器
  nexthop_type = "Attachment"
  # 下一跳 ID  转发路由器 VPC 附加资源
  nexthop_id = alicloud_cen_transit_router_vpc_attachment.a.transit_router_attachment_id
}
// 配置系统路由表 路由条目 VPC_B
resource "alicloud_route_entry" "b" {
  # 系统路由表id
  route_table_id = alicloud_vpc.b.route_table_id
  # 目标网段
  destination_cidrblock = "172.16.20.0/24"
  # 下一跳类型  传输路由器
  nexthop_type = "Attachment"
  # 下一跳 ID 转发路由器 VPC 附加资源
  nexthop_id = alicloud_cen_transit_router_vpc_attachment.b.transit_router_attachment_id
}
// 5.2 分别为VPC_A、VPC_B的自定义路由表配置路由条目。下一跳为 VPC NAT实例
// 配置自定义路由表 路由条目 VPC_A
resource "alicloud_route_entry" "aa" {
  # 自定义路由表id
  route_table_id = alicloud_route_table.a.id
  # 目标网段 B
  destination_cidrblock = "10.0.20.0/24"
  # 下一跳类型 NAT网关
  nexthop_type = "NatGateway"
  # 下一跳 ID 
  nexthop_id = alicloud_nat_gateway.a.id
}
// 配置自定义路由表 路由条目 VPC_B
resource "alicloud_route_entry" "bb" {
  # 自定义路由表id
  route_table_id = alicloud_route_table.b.id
  # 目标网段 A
  destination_cidrblock = "172.16.20.0/24"
  # 下一跳类型 NAT网关
  nexthop_type = "NatGateway"
  # 下一跳 ID
  nexthop_id = alicloud_nat_gateway.b.id
}
// 输出
output "vswitch_a1_id" {
  value = alicloud_vswitch.a1.id
}
output "vpc_a_id" {
  value = alicloud_vpc.a.id
}
output "vswitch_b1_id" {
  value = alicloud_vswitch.b1.id
}
output "vpc_b_id" {
  value = alicloud_vpc.b.id
}
output "nat_gateway_a_id" {
  value = alicloud_nat_gateway.a.id
}
output "nat_gateway_b_id" {
  value = alicloud_nat_gateway.b.id
}
output "nat_gateway_nat_ip" {
  value = alicloud_nat_gateway.a.id
}
// 输出创建的默认 VPC NAT A 和 VPC NAT B 的 NAT IP 的信息
output "default_nat_ip_a_id" {
  value = local.default_nat_ip_a.id
}
output "default_nat_ip_a_cidr" {
  value = local.default_nat_ip_a.nat_ip_cidr
}
output "default_nat_ip_a_name" {
  value = local.default_nat_ip_a.nat_ip_name
}
output "default_nat_ip_a_nat_ip" {
  value = local.default_nat_ip_a.nat_ip
}
output "default_nat_ip_b_id" {
  value = local.default_nat_ip_b.id
}
output "default_nat_ip_b_cidr" {
  value = local.default_nat_ip_b.nat_ip_cidr
}
output "default_nat_ip_b_name" {
  value = local.default_nat_ip_b.nat_ip_name
}
output "default_nat_ip_b_nat_ip" {
  value = local.default_nat_ip_b.nat_ip
}
// 输出查询的CEN 传输路由器信息
output "transit_router_id" {
  // 传输路由器ID
  value = data.alicloud_cen_transit_router_route_tables.cen_route_table_id.transit_router_id
}
output "transit_router_System_route_table_id" {
  // 传输路由器系统路由表ID
  value = data.alicloud_cen_transit_router_route_tables.cen_route_table_id.tables[0].transit_router_route_table_id
}

variable "region" {
  default = "cn-shanghai"
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
# 镜像
data "alicloud_images" "default" {
  most_recent = true
  owners      = "system"
}
# 类型
data "alicloud_instance_types" "default" {
  availability_zone = data.alicloud_zones.default.zones.0.id
  image_id          = data.alicloud_images.default.images.0.id
}
# 可用区
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
  available_disk_category     = "cloud_efficiency"
}
locals {
  image_id = "aliyun_3_x64_20G_alibase_20241103.vhd"
}
# 创建VPC
resource "alicloud_vpc" "vpc" {
  vpc_name   = var.name
  cidr_block = "192.168.0.0/16"
}
# 创建一个Vswitch CIDR 块为 192.168.20.0/24
resource "alicloud_vswitch" "vsw" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.20.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = var.name
}
# 安全组
resource "alicloud_security_group" "example" {
  security_group_name = var.name
  vpc_id              = alicloud_vpc.vpc.id
}
// 安全组 VPC_B 规则
resource "alicloud_security_group_rule" "b" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 1
  security_group_id = alicloud_security_group.example.id
  cidr_ip           = "0.0.0.0/0"
}
# 创建ECS实例
resource "alicloud_instance" "example" {
  # 实例镜像
  // image_id                   = data.alicloud_images.default.images.0.id
  image_id = local.image_id
  # 启动类型
  instance_type = data.alicloud_instance_types.default.instance_types.0.id
  # 安全组
  security_groups = alicloud_security_group.example.*.id
  # 实例的互联网收费类型
  internet_charge_type = "PayByTraffic"
  # 向公共网络的最大出站带宽，以 Mbps（兆位每秒）为单位。值范围：[0，100]。
  internet_max_bandwidth_out = "0"
  # 启动实例的可用区
  // availability_zone          = data.alicloud_instance_types.default.instance_types.0.availability_zones.0
  availability_zone = data.alicloud_zones.default.zones.0.id
  # 有效值为 PrePaid、PostPaid，默认值为 PostPaid。
  instance_charge_type = "PostPaid"
  # 仅对一些非 I/O 优化实例使用。
  system_disk_category = "cloud_efficiency"
  # 交换机id
  vswitch_id = alicloud_vswitch.vsw.id
  # 实例名称
  instance_name = var.name
  # vpc-A ID
  vpc_id = alicloud_vpc.vpc.id
  # 密码
  password = var.password
}
# 创建公网 NAT 网关
resource "alicloud_nat_gateway" "default" {
  vpc_id           = alicloud_vpc.vpc.id
  nat_gateway_name = var.name
  vswitch_id       = alicloud_vswitch.vsw.id
  # 增强型
  nat_type = "Enhanced"
  # 是否强制删除
  force = true
  # 计费类型
  payment_type = "PayAsYouGo"
  # 网关类型 internet和intranet。internet: 互联网NAT网关。intranet: VPC NAT网关。
  network_type = "internet"
  # 是否启用删除保护。默认值：false。
  deletion_protection = false
}
# 创建 eip 弹性公网
resource "alicloud_eip_address" "default" {
  description  = var.name
  isp          = "BGP"
  address_name = var.name
  # 网络类型。默认值为public，表示公用网络类型。
  netmode = "public"
  # 弹性公共网络的最大带宽
  bandwidth = "1"
  # EIP的计费方式。有效值：Subscription和PayAsYouGo
  payment_type = "PayAsYouGo"
  # 是否启用删除保护。默认值：false。
  deletion_protection = false
}
# eip 绑定到NAT网关
resource "alicloud_eip_association" "example" {
  # EIP实例的ID。
  allocation_id = alicloud_eip_address.default.id
  # NAT ID
  instance_id = alicloud_nat_gateway.default.id
  # 绑定的 NAT 实例类型
  instance_type = "Nat"
}
# 创建 SNAT 条目，选择绑定的 eip
resource "alicloud_snat_entry" "default" {
  snat_entry_name = var.name
  # 该值可以从alicloud_nat_gateway的属性"snat_table_ids"获取。
  snat_table_id = alicloud_nat_gateway.default.snat_table_ids
  # 绑定交换机
  source_vswitch_id = alicloud_vswitch.vsw.id
  # SNAT的IP地址，IP必须与alicloud_nat_gateway参数bandwidth_packages中的带宽包公共IP一致。
  snat_ip = alicloud_eip_address.default.ip_address
}
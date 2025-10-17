# ------------------------------------------------------------------------------
# 核心资源定义 (Main Resource Definitions)
#
# 本文件包含了模块的核心基础设施资源。
# 这里的代码负责根据输入变量来创建和配置所有云资源。
# ------------------------------------------------------------------------------

# 配置阿里云提供商 (Provider)
provider "alicloud" {
  # 资源部署地域
  region = "cn-hangzhou"
}

# 生成随机ID后缀
resource "random_id" "suffix" {
  byte_length = 8
}

# 定义本地变量
locals {
  common_name = random_id.suffix.id
}

# 创建VPC
resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "${local.common_name}-vpc"
}

# 创建交换机
resource "alicloud_vswitch" "vswitch1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.1.0/24"
  zone_id      = var.region_zone_id1
  vswitch_name = "${local.common_name}-app1-vsw"
}

# 创建交换机
resource "alicloud_vswitch" "vswitch2" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.2.0/24"
  zone_id      = var.region_zone_id2
  vswitch_name = "${local.common_name}-app2-vsw"
}

# 创建交换机（NAT网关）
resource "alicloud_vswitch" "vswitch3" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.3.0/24"
  zone_id      = var.region_zone_id1
  vswitch_name = "${local.common_name}-pub-vsw"
}

# 创建安全组
resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "${local.common_name}-sg"
}

# 安全组规则：允许HTTPS
resource "alicloud_security_group_rule" "allow_https" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "443/443"
  cidr_ip           = "0.0.0.0/0"
  security_group_id = alicloud_security_group.security_group.id
}

# 安全组规则：允许HTTP
resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "80/80"
  cidr_ip           = "0.0.0.0/0"
  security_group_id = alicloud_security_group.security_group.id
}

# 安全组规则：允许SSH
resource "alicloud_security_group_rule" "allow_workbench" {
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "22/22"
  cidr_ip           = "100.104.0.0/16"
  security_group_id = alicloud_security_group.security_group.id
}

# 创建ECS1
resource "alicloud_instance" "ecs_instance1" {
  instance_name              = "${local.common_name}-ecs-1"
  image_id                   = "aliyun_3_9_x64_20G_alibase_20231219.vhd"
  instance_type              = var.instance_type1
  system_disk_category       = "cloud_essd"
  vswitch_id                 = alicloud_vswitch.vswitch1.id
  security_groups            = [alicloud_security_group.security_group.id]
  internet_max_bandwidth_out = 0
  password                   = var.ecs_instance_password
}

# 创建ECS2
resource "alicloud_instance" "ecs_instance2" {
  instance_name              = "${local.common_name}-ecs-2"
  image_id                   = "aliyun_3_9_x64_20G_alibase_20231219.vhd"
  instance_type              = var.instance_type2
  system_disk_category       = "cloud_essd"
  vswitch_id                 = alicloud_vswitch.vswitch2.id
  security_groups            = [alicloud_security_group.security_group.id]
  internet_max_bandwidth_out = 0
  password                   = var.ecs_instance_password
}

# 创建NAT网关
resource "alicloud_nat_gateway" "nat_gateway" {
  vpc_id           = alicloud_vpc.vpc.id
  vswitch_id       = alicloud_vswitch.vswitch3.id
  nat_type         = "Enhanced"
  nat_gateway_name = "${local.common_name}-ngw"
}

# 创建EIP
resource "alicloud_eip" "eip" {
  bandwidth            = 200
  internet_charge_type = "PayByTraffic"
  isp                  = "BGP"
  deletion_protection  = false
}

# 绑定EIP到NAT网关
resource "alicloud_eip_association" "eip_association" {
  instance_id   = alicloud_nat_gateway.nat_gateway.id
  allocation_id = alicloud_eip.eip.id
}

# 配置SNAT规则（vswitch1）
resource "alicloud_snat_entry" "snat" {
  snat_table_id     = alicloud_nat_gateway.nat_gateway.snat_table_ids
  snat_ip           = alicloud_eip.eip.ip_address
  source_vswitch_id = alicloud_vswitch.vswitch1.id
  snat_entry_name   = "${local.common_name}-snat"
  depends_on        = [alicloud_eip_association.eip_association]
}

# 配置SNAT规则（vswitch2）
resource "alicloud_snat_entry" "snat2" {
  snat_table_id     = alicloud_nat_gateway.nat_gateway.snat_table_ids
  snat_ip           = alicloud_eip.eip.ip_address
  source_vswitch_id = alicloud_vswitch.vswitch2.id
  snat_entry_name   = "${local.common_name}-snat2"
  depends_on        = [alicloud_eip_association.eip_association]
}
# ------------------------------------------------------------------------------
# 核心资源定义
#
# 本文件包含了模块的核心基础设施资源
# 这里的代码负责根据输入变量来创建和配置所有云资源
# ------------------------------------------------------------------------------

# 配置阿里云提供商
provider "alicloud" {
  region = "cn-hangzhou"
}

# 创建一个随机ID
resource "random_id" "suffix" {
  byte_length = 8
}

# 定义一个局部变量
locals {
  common_name = random_id.suffix.id
}

# 查询满足条件的可用区
data "alicloud_db_zones" "zones_ids" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
}

# 创建专有网络VPC
resource "alicloud_vpc" "vpc" {
  vpc_name = "vpc-${local.common_name}"
  cidr_block = "192.168.0.0/16"
}

# 创建交换机VSwitch
resource "alicloud_vswitch" "vswitch" {
  vpc_id = alicloud_vpc.vpc.id
  zone_id = data.alicloud_db_zones.zones_ids.ids.1
  cidr_block = "192.168.0.0/24"
  vswitch_name = "vsw-${local.common_name}"
}

# 创建安全组
resource "alicloud_security_group" "security_group" {
  vpc_id = alicloud_vpc.vpc.id
}

# 创建RDS实例
resource "alicloud_db_instance" "rds_instance" {
  engine = "MySQL"
  instance_storage = 40
  engine_version = "8.0"
  security_ips = ["192.168.0.0/16"]
  vpc_id = alicloud_vpc.vpc.id
  zone_id = data.alicloud_db_zones.zones_ids.ids.1
  vswitch_id = alicloud_vswitch.vswitch.id
  instance_charge_type = "Postpaid"
  instance_type = "mysql.n2.medium.1"
  category = "Basic"
  db_instance_storage_type = "cloud_essd"
}

# 创建数据库
resource "alicloud_db_database" "database" {
  character_set   = "utf8"
  instance_id     = alicloud_db_instance.rds_instance.id
  name            = "mysqltest"
}

# 创建数据库账号
resource "alicloud_db_account" "default" {
  db_instance_id      = alicloud_db_instance.rds_instance.id
  account_name        = var.rds_db_user
  account_password    = var.db_password
  account_type        = "Super"
}
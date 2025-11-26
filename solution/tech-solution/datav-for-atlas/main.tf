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

# 生成随机ID用于资源命名
resource "random_id" "suffix" {
  keepers = {
    user = var.rds_db_user
  }
  byte_length = 4
}

# 定义本地变量
locals {
  instance_name = "datav-${var.rds_db_user}-${random_id.suffix.hex}"
  connection_prefix = "datav-pg-${random_id.suffix.hex}"
}

# 查询可用区
data "alicloud_db_zones" "default" {
  engine                   = "PostgreSQL"
  engine_version           = "17.0"
  instance_charge_type     = "PostPaid"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
}

# 创建VPC
resource "alicloud_vpc" "vpc" {
  vpc_name   = "VPC_HZ_${random_id.suffix.hex}"
  cidr_block = "192.168.0.0/16"
}

# 创建VSwitch
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.1.0/24"
  vswitch_name = "vsw_001"
  zone_id      =  data.alicloud_db_zones.default.zones[0].id
}

# 创建PostgreSQL实例
resource "alicloud_db_instance" "db_instance" {
  engine                   = "PostgreSQL"
  engine_version           = "17.0"
  instance_storage         = "50"
  instance_type            = var.db_instance_class
  instance_charge_type     = "Postpaid"
  instance_name            = local.instance_name
  zone_id                  = data.alicloud_db_zones.default.zones[0].id
  vswitch_id               = alicloud_vswitch.vswitch.id
  db_instance_storage_type = "cloud_essd"
  category                 = "Basic"
  security_ips             = ["47.99.0.0/16", "192.168.0.0/16"]
}

# 创建公网连接
resource "alicloud_db_connection" "public" {
  instance_id       = alicloud_db_instance.db_instance.id
  connection_prefix = local.connection_prefix
  port              = "5432"
}

# 创建RDS账号
resource "alicloud_rds_account" "account" {
  db_instance_id   = alicloud_db_instance.db_instance.id
  account_type     = "Super"
  account_password = var.db_password
  account_name     = var.rds_db_user
}

# 创建RDS数据库
resource "alicloud_db_database" "db_database" {
  instance_id   = alicloud_db_instance.db_instance.id
  character_set = "utf8"
  name          = var.db_name
}

# 设置RDS账号权限
resource "alicloud_db_account_privilege" "privilege" {
  instance_id  = alicloud_db_instance.db_instance.id
  account_name = alicloud_rds_account.account.account_name
  privilege    = "DBOwner"
  db_names     = alicloud_db_database.db_database.*.name
}
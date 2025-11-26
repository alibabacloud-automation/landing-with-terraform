# ------------------------------------------------------------------------------
# 核心资源定义
#
# 本文件包含了模块的核心基础设施资源
# 这里的代码负责根据输入变量来创建和配置所有云资源
# ------------------------------------------------------------------------------

# 配置阿里云提供商
provider "alicloud" {
  region = "cn-beijing"
}

# 创建随机字符串用于命名
resource "random_string" "lowercase" {
  length  = 8
  special = false
  upper   = false
  numeric = false
}

# 创建随机ID用于命名
resource "random_id" "suffix" {
  byte_length = 8
}

# 定义本地变量用于统一命名
locals {
  common_name = "SmartSearch-${random_id.suffix.id}"
}

# 查询可用区
data "alicloud_polardb_node_classes" "default" {
  db_type    = "PostgreSQL"
  pay_type   = "PostPaid"
  category   = "SENormal"
}

# 创建VPC
resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "VPC_${local.common_name}"
}

# 创建VSwitch
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.1.0/24"
  zone_id      = data.alicloud_polardb_node_classes.default.classes[0].zone_id
  vswitch_name = "vsw_001_${local.common_name}"
}

# 创建PolarDB集群
resource "alicloud_polardb_cluster" "polardb_cluster" {
  vpc_id              = alicloud_vpc.vpc.id
  db_type             = "PostgreSQL"
  vswitch_id          = alicloud_vswitch.vswitch.id
  db_version          = "14"
  creation_category   = "SENormal"
  storage_space       = 20
  hot_standby_cluster = "OFF"
  db_node_class       = "polar.pg.g2.2xlarge.c"
  pay_type            = "PostPaid"
  storage_type        = "ESSDPL1"
  security_ips        = ["0.0.0.0/0"]
  db_node_num         = 2
}

# 创建PolarDB账户
resource "alicloud_polardb_account" "account" {
  db_cluster_id    = alicloud_polardb_cluster.polardb_cluster.id
  account_name     = var.account_name
  account_password = var.db_password
  account_type     = "Super"
}

# 查询PolarDB端点信息
data "alicloud_polardb_endpoints" "polardb_endpoints" {
  db_cluster_id = alicloud_polardb_cluster.polardb_cluster.id
}

# 创建PolarDB端点地址
# Create PolarDB endpoint address
resource "alicloud_polardb_endpoint_address" "dbcluster_endpoint_address" {
  db_endpoint_id = data.alicloud_polardb_endpoints.polardb_endpoints.endpoints[0].db_endpoint_id
  db_cluster_id  = alicloud_polardb_cluster.polardb_cluster.id
  net_type       = "Public"
  depends_on = [
    alicloud_polardb_account.account
  ]
}

# 创建PolarDB数据库
resource "alicloud_polardb_database" "polardb_database" {
  db_cluster_id      = alicloud_polardb_cluster.polardb_cluster.id
  db_name            = var.dbname
  character_set_name = "utf8"
  account_name       = var.account_name
}

# 启用OSS服务
data "alicloud_oss_service" "open_oss" {
  enable = "On"
}

# 创建OSS存储桶
resource "alicloud_oss_bucket" "ossbucket" {
  bucket          = "${var.bucket_name}-${random_string.lowercase.result}"
  force_destroy   = true
  redundancy_type = "ZRS"
}
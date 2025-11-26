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

# 定义本地变量
locals {
  common_name = "polardb-${random_id.suffix.id}"
}

# 查询可用区
data "alicloud_polardb_node_classes" "default" {
  db_type    = "MySQL"
  pay_type   = "PostPaid"
  category   = "SENormal"
}

# 创建专有网络VPC
resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "VPC_${local.common_name}"
}

# 创建交换机VSwitch
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = data.alicloud_polardb_node_classes.default.classes[0].zone_id
  vswitch_name = "vsw_001_${local.common_name}"
}

# 创建PolarDB集群
resource "alicloud_polardb_cluster" "polardb_cluster" {
  vpc_id            = alicloud_vpc.vpc.id
  db_type           = "MySQL"
  zone_id           = data.alicloud_polardb_node_classes.default.classes[0].zone_id
  vswitch_id        = alicloud_vswitch.vswitch.id
  db_version        = "8.0"
  creation_category = "SENormal"
  storage_space     = 40
  db_node_class     = "polar.mysql.g1.tiny.c"
  pay_type          = "PostPaid"
  storage_type      = "ESSDAUTOPL"
  security_ips      = ["0.0.0.0/0"]
}

# 创建PolarDB账号
resource "alicloud_polardb_account" "account" {
  db_cluster_id    = alicloud_polardb_cluster.polardb_cluster.id
  account_name     = var.account_name
  account_password = var.db_password
  account_type     = "Super"
}

# 获取PolarDB集群的端点信息
data "alicloud_polardb_endpoints" "polardb_endpoints" {
  db_cluster_id = alicloud_polardb_cluster.polardb_cluster.id
  depends_on    = [alicloud_polardb_cluster.polardb_cluster]
}

# 创建PolarDB集群的公网连接地址
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
# ------------------------------------------------------------------------------
# 核心资源定义
#
# 本文件包含了模块的核心基础设施资源。
# 这里的代码负责根据输入变量来创建和配置所有云资源。
# ------------------------------------------------------------------------------

# 配置阿里云提供商
provider "alicloud" {
  region = "cn-hangzhou"
}

# 创建随机ID
resource "random_id" "suffix" {
  byte_length = 8
}

# 定义本地变量
locals {
  common_name = "es-${random_id.suffix.id}"
}

# 获取当前区域的信息
data "alicloud_regions" "current_region_ds" {
  current = true
}

# 声明Elasticsearch可用区数据源
data "alicloud_elasticsearch_zones" "zones_ids" {
}

# 创建VPC
resource "alicloud_vpc" "ecs_vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "VPC_${local.common_name}"
}

# 创建交换机
resource "alicloud_vswitch" "ecsvswitch" {
  vpc_id       = alicloud_vpc.ecs_vpc.id
  cidr_block   = "192.168.1.0/24"
  zone_id      = data.alicloud_elasticsearch_zones.zones_ids.zones.0.id
  vswitch_name = "vsw_001_${local.common_name}"
}

# 创建Elasticsearch实例
resource "alicloud_elasticsearch_instance" "elasticsearch" {
  instance_charge_type = "PostPaid"
  vswitch_id           = alicloud_vswitch.ecsvswitch.id
  version              = "8.17.0_with_X-Pack"
  zone_count           = 1
  data_node_disk_type  = "cloud_essd"
  data_node_disk_size  = "20"
  data_node_amount     = "2"
  data_node_spec       = "elasticsearch.sn1ne.large.new"
  kibana_whitelist = [var.public_ip]
  kibana_node_spec     = "elasticsearch.n4.small"
  password             = var.elasticsearch_password
  description          = "elasticsearch-test_${local.common_name}"
}
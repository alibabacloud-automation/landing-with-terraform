variable "region" {
  default = "cn-qingdao"
}
provider "alicloud" {
  region = var.region
}
variable "name" {
  default = "lindormtest"
}
locals {
  zone_id = "cn-qingdao-b"
}
# 创建 alicloud_vpc 资源
resource "alicloud_vpc" "vpc1" {
  vpc_name   = var.name
  cidr_block = "172.16.0.0/12"
}
# 在 local.zone_id 地区创建 alicloud_vpc 资源下的 alicloud_vswitch 资源
resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "172.16.20.0/24"
  vpc_id       = alicloud_vpc.vpc1.id
  zone_id      = local.zone_id
}
# 创建Lindorm实例
resource "alicloud_lindorm_instance" "default" {
  timeouts {
    create = "60m" # 给创建加上超时时间
  }
  #  (必需，强制新建) 实例的磁盘类型。有效值：cloud_efficiency, cloud_ssd, cloud_essd, cloud_essd_pl0, capacity_cloud_storage, local_ssd_pro, local_hdd_pro。注意：自版本 1.207.0 起，disk_category 可以设置为 cloud_essd_pl0。
  disk_category = "cloud_efficiency"
  # (必需，强制新建) 计费方式。有效值：PayAsYouGo 和 Subscription。
  payment_type = "PayAsYouGo"
  vpc_id       = alicloud_vpc.vpc1.id
  # (必需，强制新建) 虚拟交换机 ID。
  vswitch_id = alicloud_vswitch.default.id
  # 实例名称
  instance_name = var.name
  # (可选) 表引擎的规格。有效值：lindorm.c.2xlarge, lindorm.c.4xlarge, lindorm.c.8xlarge, lindorm.g.xlarge, lindorm.g.2xlarge, lindorm.g.4xlarge, lindorm.g.8xlarge。
  table_engine_specification = "lindorm.g.xlarge"
  #  (可选，整型) 表引擎的节点数量。
  table_engine_node_count = "2"
  #  (可选) 实例的存储容量。单位：GB。
  instance_storage = "80"
  #  (可选，布尔型) 实例的删除保护。
  # deletion_protection        = false
}
variable "region" {
  default = "cn-qingdao"
}
provider "alicloud" {
  region = var.region
}
data "alicloud_hbase_zones" "default" {}
variable "instance_type" {
  default = "hbase.sn2.large"
}
variable "name" {
  default = "hbasetest"
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
  zone_id      = data.alicloud_hbase_zones.default.zones[0].id
}
resource "alicloud_hbase_instance" "default" {
  timeouts {
    create = "100m" # 给创建加上超时时间
  }
  # (必填) HBase 实例名称，长度必须为 2-128 个字符，只允许使用中文字符、英文字母、数字、句点 (.)、下划线 (_) 或短横线 (-)。
  name = var.name
  #  (可选，ForceNew) 启动 HBase 实例的区域。
  zone_id = data.alicloud_hbase_zones.default.zones[0].id
  # (可选，ForceNew) 
  vswitch_id = alicloud_vswitch.default.id
  #  (可选，ForceNew，从 v1.185.0 起可用) VPC 的 ID。
  vpc_id = alicloud_vpc.vpc1.id
  #  (可选，ForceNew) 有效值为 "hbase/hbaseue/bds"。自 v1.73.0 之后支持的类型包括 hbaseue 和 bds。单个 HBase 实例需要设置 engine=hbase，core_instance_quantity=1。
  engine = "hbaseue"
  # (必填，ForceNew) HBase 主版本，hbase:1.1/2.0, hbaseue:2.0, bds:1.0，当前暂不支持其他引擎。
  engine_version = "2.0"
  # (必填) 实例规格
  master_instance_type = var.instance_type
  # (必填) 实例规格
  core_instance_type = var.instance_type
  # (可选) 默认值为 2，范围为 [1-200]。若 core_instance_quantity > 1，则为集群实例；若 core_instance_quantity = 1，则为单个实例。
  core_instance_quantity = "2"
  #  (可选，ForceNew) 有效值为 cloud_ssd, cloud_essd_pl1, cloud_efficiency, local_hdd_pro, local_ssd_pro，``，local_disk 大小是固定的。当 engine=bds 时，无需设置磁盘类型（或空字符串）。
  core_disk_type = "cloud_ssd"
  # (可选) 用户定义的 HBase 实例每个核心节点的存储，仅在 engine=hbase/hbaseue 时有效。Bds 引擎无需设置 core_disk_size，单位：GB。值范围：
  # 自定义存储空间，值范围：[20, 64000]。
  # 集群 [400, 64000]，步长：40-GB 增量。
  # 单个 [20-500GB]，步长：1-GB 增量。
  core_disk_size = 400
  #  (可选) 有效值为 PrePaid, PostPaid，系统默认为 PostPaid。也可以从 PostPaid 转换为 PrePaid，支持从 v1.115.0+ 将 PrePaid 转换为 PostPaid。
  pay_type = "PostPaid"
  # (可选) 0 或 [800, 100000000]，步长：10-GB 增量。0 表示 is_cold_storage = false。[800, 100000000] 表示 is_cold_storage = true。
  cold_storage_size = 0
  # (可选，从 1.109.0 起可用) 立即删除开关。True: 立即删除，False: 延迟删除。无论设置为 true 还是 false，您都将无法找到集群。
  immediate_delete_flag = true
  # (可选) 有效值为 1, 2, 3, 4, 5, 6, 7, 8, 9, 12, 24, 36，仅在 pay_type = PrePaid 时有效，单位：月。12, 24, 36 表示 1, 2, 3 年。
  duration = 1
  # (可选，从 1.73.0 起可用) 删除保护开关。True: 删除保护，False: 不做删除保护。如果您想删除集群，必须设置为 false。
  deletion_protection = false
}
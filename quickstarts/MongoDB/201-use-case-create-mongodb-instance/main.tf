variable "region" {
  default = "cn-heyuan"
}
provider "alicloud" {
  region = var.region
}
# 声明变量名: name
variable "name" {
  default = "terraform-example-1125"
}
# 查询可用区信息: alicloud_mongodb_zones
data "alicloud_mongodb_zones" "default" {
}
# 声明本地值, zone_id 取 alicloud_mongodb_zones 中的最后一个可用区
locals {
  index   = length(data.alicloud_mongodb_zones.default.zones) - 1
  zone_id = data.alicloud_mongodb_zones.default.zones[local.index].id
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

# 使用上述vpc、vswitch信息创建单节点资源
resource "alicloud_mongodb_instance" "singleNode" {
  # （必填）数据库版本。
  engine_version = "7.0"
  # （必填）实例规格。
  db_instance_class = "mdb.shard.2x.xlarge.d"
  # （必填，整型）用户定义的数据库实例存储空间。单位：GB。
  db_instance_storage = 20
  # 实例的网络类型
  network_type = "VPC"
  # （可选，需强制新建）在一个 VPC 中启动数据库实例的虚拟交换机 ID。
  vswitch_id = alicloud_vswitch.default.id
  # vpc_id
  vpc_id = alicloud_vpc.vpc1.id
  # （可选，需强制新建）启动数据库实例的可用区。
  zone_id = local.zone_id
  # 实例名称  
  name = var.name
  # （可选）要分配给资源的标签映射。
  tags = {
    Created = "TF"
    For     = "example"
  }
  # （可选，列表）允许访问实例所有数据库的 IP 地址列表。
  security_ip_list = [
    "10.168.1.12",
    "100.69.7.112"
  ]
  # （可选，自 v1.199.0 起可用）实例的存储类型。
  # storage_type        = "cloud_auto"   
}
# 使用上述vpc、vswitch信息创建分片集群资源
#resource "alicloud_mongodb_sharding_instance" "default" {
# (必填) 数据库版本
#engine_version      = "7.0"
# (可选，ForceNew) 启动 DB 实例的虚拟交换机 ID。
#vswitch_id          = alicloud_vswitch.default.id
# 实例的网络类型
#network_type        = "VPC"
# vpc_id
#vpc_id              = alicloud_vpc.vpc1.id
# 实例名称
#name                = var.name
# 可选地区
#zone_id = local.zone_id
# 实例的 Mongo 节点。可购买的 mongo 节点数范围为 [2, 32]，见下方的 mongo_list。
#mongo_list {
# (必填) mongo 节点的实例类型
#node_class = "mdb.shard.2x.xlarge.d"
#}
#mongo_list {
#node_class = "mdb.shard.2x.xlarge.d"
#}
# (必填，集合) 实例的分片节点。可购买的 shard 节点数范围为 [2, 32]，见下方的 shard_list。
#shard_list {
# (必填) 分片节点的实例类型
#node_class   = "mdb.shard.2x.xlarge.d"
#  (必填，Int) 分片节点的存储空间。
#node_storage = "20"
#}
#shard_list {
#node_class        = "mdb.shard.2x.xlarge.d"
#node_storage      = "20"
# 分片节点中只读节点的数量。默认值：0。有有效值：0 到 5。
#readonly_replicas = "1"
#}
#config_server_list {
# 配置服务器节点的实例类型。有效值：mdb.shard.2x.xlarge.d，dds.cs.mid。
#node_class ="mdb.shard.2x.xlarge.d"
# 配置服务器节点的存储空间。
#node_storage = "20"
#}
# 
#tags = {
#Created = "TF"
#For     = "Example"
#}
#}
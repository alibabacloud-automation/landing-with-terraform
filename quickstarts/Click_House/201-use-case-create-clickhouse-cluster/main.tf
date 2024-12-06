variable "region" {
  default = "cn-qingdao"
}
provider "alicloud" {
  region = var.region
}
variable "name" {
  default = "tf-example-ClickHouse"
}
variable "type" {
  default = "Normal"
}
variable "account_password" {
  default = "testPassword123%"
}
variable "account_name" {
  default = "test_account"
}
variable "account_description" {
  default = "createdByTerraform"
}
variable "storage_type" {
  default = "cloud_essd"
}
data "alicloud_click_house_regions" "default" {
  region_id = var.region
  # current = true
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
  zone_id      = data.alicloud_click_house_regions.default.regions.0.zone_ids.1.zone_id
}
# 创建ClickHouse集群实例
resource "alicloud_click_house_db_cluster" "default" {
  timeouts {
    create = "60m" # 给创建加上超时时间
  }
  # （必需，强制新建）DBCluster 版本。有效值：20.3.10.75, 20.8.7.15, 21.8.10.19, 22.8.5.29, 23.8。
  db_cluster_version = "23.8"
  # （必需，强制新建）DBCluster 的类别。有效值：Basic, HighAvailability。
  category = "Basic"
  # （必需，强制新建）DBCluster 类别。根据类别，db_cluster_class 有两个值范围：
  #  如果类别是 Basic，有效值：LS20, LS40, LS80, S8, S16, S32, S64, S80, S104。
  # 如果类别是 HighAvailability，有效值：LC20, LC40, LC80, C8, C16, C32, C64, C80, C104。
  db_cluster_class = "S8"
  # （必需，强制新建）DBCluster 网络类型。有效值：vpc。
  db_cluster_network_type = "vpc"
  # （必需，强制新建）数据库节点组数量。数字范围为 1 到 48。
  db_node_group_count = "1"
  # （必需，强制新建）资源的支付类型。有效值：PayAsYouGo, Subscription。
  payment_type = "PayAsYouGo"
  # （必需）数据库节点存储。
  db_node_storage = "100"
  # （必需，强制新建）DBCluster 的存储类型。有效值：cloud_essd, cloud_efficiency, cloud_essd_pl2, cloud_essd_pl3。
  storage_type = var.storage_type
  # （可选，强制新建）DBCluster 的 vswitch ID。
  vswitch_id = alicloud_vswitch.default.id
  vpc_id     = alicloud_vpc.vpc1.id
  # （可选）资源状态。有效值：Running, Creating, Deleting, Restarting, Preparing。
  status = "Running"
}
# 创建账号。
resource "alicloud_click_house_account" "default" {
  # （必需，强制新建）数据库集群 ID。
  db_cluster_id = alicloud_click_house_db_cluster.default.id
  # （可选）可使用中文、英文字符。可以包含中文和英文字符、小写字母、数字和下划线（_）、短横线（-）。
  account_description = var.account_description
  # （必需，强制新建）账户名称：小写字母、数字、下划线，必须是小写字母；长度不超过 16 个字符。
  account_name = var.account_name
  # （必需）账户密码：包含大写字母、小写字母、数字和特殊字符（特殊字符包括 !#$%^&*()_+-=），长度为 8-32 位。
  account_password = var.account_password
  # （可选，强制新建）数据库账户类型。有效值：Normal 或 Super。
  type = var.type
}
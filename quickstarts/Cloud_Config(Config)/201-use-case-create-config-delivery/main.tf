variable "region" {
  default = "cn-heyuan"
}
provider "alicloud" {
  region = var.region
}
variable "name" {
  default = "tf-example-sls"
}
variable "description" {
  default = "terraform-example"
}
# 获取当前用户uid
data "alicloud_account" "this" {}
# 获取区域信息
data "alicloud_regions" "this" {
  current = true
}
# 随机数
resource "random_integer" "default" {
  max = 99999
  min = 10000
}
#  创建SLS 项目资源
resource "alicloud_log_project" "default" {
  # 描述
  description = var.description
  # 名称
  project_name = "${var.name}-${random_integer.default.result}"
}
# 创建SLS日志存储资源
resource "alicloud_log_store" "default" {
  # 名称
  logstore_name = var.name
  #（可选，强制新建，自 v1.215.0 起可用）该日志存储所属的项目名称。
  project_name = alicloud_log_project.default.project_name
  # （可选，强制新建，计算得出，整数）该日志存储中的分片数量。默认为 2。
  shard_count = 2
  # （可选）决定是否自动拆分分片。默认为 false。
  auto_split = true
  # （可选，整数）自动拆分的最大分片数，范围为 1 到 256。
  max_split_shard_count = 60
  # （可选，计算得出）决定是否自动附加日志元数据。元数据包括日志接收时间和客户端 IP 地址。默认为 true。
  append_meta = true
  # （可选，计算得出，整数）数据保留时间（以天为单位）。有效值：[1-3650]。
  retention_period = 30
}
# 创建投递渠道
resource "alicloud_config_delivery" "default" {
  # （可选）指示指定的目标是否接收资源更改日志。如果该值为 true
  configuration_item_change_notification = true
  # （可选）指示指定的目标是否接收资源不合规事件
  non_compliant_notification = true
  # （可选）交付通道的名称
  delivery_channel_name = var.name
  # （必需）交付目标的 ARN
  delivery_channel_target_arn = "acs:log:${data.alicloud_regions.this.ids.0}:${data.alicloud_account.this.id}:project/${alicloud_log_project.default.project_name}/logstore/${alicloud_log_store.default.logstore_name}"
  # （必需，强制新建）交付通道的类型
  delivery_channel_type = "SLS"
  # 描述
  description = var.description
  # 状态0：交付通道已禁用，1：交付通道已启用。
  status = 1
}
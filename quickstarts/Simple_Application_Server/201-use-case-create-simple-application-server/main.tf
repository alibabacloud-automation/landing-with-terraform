variable "region" {
  default = "cn-hangzhou"
}
provider "alicloud" {
  region = var.region
}
variable "name" {
  default = "tf_example"
}
# 查询指定区域内可用的镜像。
data "alicloud_simple_application_server_images" "default" {
  platform = "Linux"
}
# 查询指定区域内简单应用服务器提供的所有计划。
data "alicloud_simple_application_server_plans" "default" {
  platform = "Linux"
}
# 创建轻量级服务器实例
resource "alicloud_simple_application_server_instance" "default" {
  #  (可选，强制新建) 资源的支付类型。有效值：Subscription。
  payment_type = "Subscription"
  # (必需) 计划的ID。您可以使用alicloud_simple_application_server_plans查询指定区域内简单应用服务器提供的所有计划。
  plan_id = data.alicloud_simple_application_server_plans.default.plans.0.id
  # 实例名称
  instance_name = var.name
  #  (必需) 镜像的ID。您可以使用alicloud_simple_application_server_images查询指定区域内可用的镜像。该值必须是20的整数倍。
  image_id = data.alicloud_simple_application_server_images.default.images.0.id
  # (必需) 订阅周期。单位：月。有效值：1, 3, 6, 12, 24, 36。
  period = 1
  # (可选) 数据盘的大小。单位：GB。有效值：0 到 16380。
  data_disk_size = 100
}
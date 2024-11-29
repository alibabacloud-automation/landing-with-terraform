variable "region" {
  default = "cn-heyuan"
}
provider "alicloud" {
  region = var.region
}
variable "name" {
  default = "tf_example"
}
data "alicloud_enhanced_nat_available_zones" "default" {
}
# 创建VPC 
resource "alicloud_vpc" "vpc" {
  vpc_name   = var.name
  cidr_block = "192.168.0.0/16"
}
# 创建交换机 
resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  zone_id      = data.alicloud_enhanced_nat_available_zones.default.zones.0.zone_id
  cidr_block   = "192.168.10.0/24"
  vpc_id       = alicloud_vpc.vpc.id
}
# 创建NAT网关实例
resource "alicloud_nat_gateway" "default" {
  # VPC ID
  vpc_id = alicloud_vpc.vpc.id
  # 网关名称
  nat_gateway_name = var.name
  # NAT网关的计费方式。有效值为：PayAsYouGo和Subscription。默认为PayAsYouGo。
  payment_type = "PayAsYouGo"
  # vSwitch ID
  vswitch_id = alicloud_vswitch.default.id
  # NAT网关的类型。有效值：Normal和Enhanced
  nat_type = "Enhanced"
  # 是否启用删除保护。默认值：false。
  deletion_protection = false
}
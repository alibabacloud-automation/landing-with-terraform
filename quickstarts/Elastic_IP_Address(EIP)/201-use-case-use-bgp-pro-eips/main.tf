variable "region" {
  default = "cn-hongkong"
}
provider "alicloud" {
  region = var.region
}
variable "name" {
  default = "ecs"
}
resource "random_integer" "default" {
  min = 10000
  max = 99999
}
variable "password" {
  default = "Test123@"
}
variable "master_zone" {
  default = "cn-hongkong-b"
}
variable "image_id" {
  default = "aliyun_3_x64_20G_alibase_20241103.vhd"
}
variable "instance_type" {
  default = "ecs.e-c1m1.large"
}
// 前置资源准备 VPC Vsw ECS
resource "alicloud_vpc" "a" {
  vpc_name   = "VPC_A"
  cidr_block = "172.16.0.0/12"
}
resource "alicloud_vswitch" "a1" {
  vpc_id       = alicloud_vpc.a.id
  cidr_block   = "172.16.20.0/24"
  zone_id      = var.master_zone
  vswitch_name = "VS_A1"
}
resource "alicloud_security_group" "a" {
  security_group_name = var.name
  vpc_id              = alicloud_vpc.a.id
}
// 安全组 VPC_A 规则
resource "alicloud_security_group_rule" "a" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 1
  security_group_id = alicloud_security_group.a.id
  cidr_ip           = "0.0.0.0/0"
}
resource "alicloud_instance" "a" {
  # 实例镜像
  image_id = var.image_id
  # 启动类型
  //   instance_type              = data.alicloud_instance_types.default.instance_types.0.id
  instance_type = var.instance_type
  # 安全组
  security_groups = alicloud_security_group.a.*.id
  # 实例的互联网收费类型
  internet_charge_type = "PayByTraffic"
  # 向公共网络的最大出站带宽，以 Mbps（兆位每秒）为单位。值范围：[0，100]。 0不创建公网IP
  internet_max_bandwidth_out = "0"
  # 启动实例的可用区
  // availability_zone          = data.alicloud_instance_types.default.instance_types.0.availability_zones.0
  availability_zone = var.master_zone
  # 有效值为 PrePaid、PostPaid，默认值为 PostPaid。
  instance_charge_type = "PostPaid"
  # 仅对一些非 I/O 优化实例使用。
  system_disk_category = "cloud_auto"
  # 交换机id
  vswitch_id = alicloud_vswitch.a1.id
  # 实例名称
  instance_name = "ECS_A_${random_integer.default.result}"
  # vpc-A ID
  vpc_id = alicloud_vpc.a.id
  # 密码
  password = var.password
}
resource "alicloud_instance" "b" {
  # 实例镜像
  image_id = var.image_id
  # 启动类型
  //   instance_type              = data.alicloud_instance_types.default.instance_types.0.id
  instance_type = var.instance_type
  # 安全组
  security_groups = alicloud_security_group.a.*.id
  # 实例的互联网收费类型
  internet_charge_type = "PayByTraffic"
  # 向公共网络的最大出站带宽，以 Mbps（兆位每秒）为单位。值范围：[0，100]。 0不创建公网IP
  internet_max_bandwidth_out = "0"
  # 启动实例的可用区
  // availability_zone          = data.alicloud_instance_types.default.instance_types.0.availability_zones.0
  availability_zone = var.master_zone
  # 有效值为 PrePaid、PostPaid，默认值为 PostPaid。
  instance_charge_type = "PostPaid"
  # 仅对一些非 I/O 优化实例使用。
  system_disk_category = "cloud_auto"
  # 交换机id
  vswitch_id = alicloud_vswitch.a1.id
  # 实例名称
  instance_name = "ECS_B_${random_integer.default.result}"
  # vpc-A ID
  vpc_id = alicloud_vpc.a.id
  # 密码
  password = var.password
}
// EIP 多线 绑定 ecs_a
resource "alicloud_eip_address" "a" {
  description = var.name
  // 多线
  isp          = "BGP"
  address_name = "ECS_A_EIP"
  # 网络类型。默认值为public，表示公用网络类型。
  netmode = "public"
  # 弹性公共网络的最大带宽
  bandwidth = "1"
  # EIP的计费方式。有效值：Subscription和PayAsYouGo
  payment_type = "PayAsYouGo"
  # 是否启用删除保护。默认值：false。
  deletion_protection = false
}
resource "alicloud_eip_association" "ecs_a" {
  allocation_id = alicloud_eip_address.a.id
  # 绑定在ECS_A上
  instance_id = alicloud_instance.a.id
  // ECS
  //   instance_type = "EcsInstance"
}
// EIP 精品多线 绑定 ecs_b
resource "alicloud_eip_address" "b" {
  description = var.name
  // 多线精品
  isp          = "BGP_PRO"
  address_name = "ECS_B_EIP"
  # 网络类型。默认值为public，表示公用网络类型。
  netmode = "public"
  # 弹性公共网络的最大带宽
  bandwidth = "1"
  # EIP的计费方式。有效值：Subscription和PayAsYouGo
  payment_type = "PayAsYouGo"
  # 是否启用删除保护。默认值：false。
  deletion_protection = false
}
resource "alicloud_eip_association" "ecs_b" {
  allocation_id = alicloud_eip_address.b.id
  instance_id   = alicloud_instance.b.id
  // ECS
  //   instance_type = "EcsInstance"
}
output "ecs_a_name" {
  value = alicloud_instance.a.instance_name
}
output "ecs_b_name" {
  value = alicloud_instance.b.instance_name
}

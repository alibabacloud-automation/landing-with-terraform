variable "region" {
  default = "cn-heyuan"
}

variable "instance_type" {
  default = "ecs.hfc7.xlarge"
}

variable "image_id" {
  default = "aliyun_2_1903_x64_20G_alibase_20210120.vhd"
}

variable "zone_id" {
  default = "cn-heyuan-b"
}

provider "alicloud" {
  region = var.region
}

#创建专有网络VPC。
resource "alicloud_vpc" "vpc" {
  vpc_name   = "tf-test-vpc-wjt"
  cidr_block = "172.16.0.0/12" #规划专有网络VPC的私网网段。
}

#创建专有网络交换机。
resource "alicloud_vswitch" "vsw" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "172.16.0.0/21" #规划交换机的私网网段。
  zone_id      = var.zone_id     #选择交换机的可用区。
  vswitch_name = "tf-test-vswitch-wjt"
}

#创建一个安全组。
resource "alicloud_security_group" "security" {
  name        = "tf_test_security"
  description = "New security group"
  vpc_id      = alicloud_vpc.vpc.id
}

#并为该安全组添加一个允许任何地址访问的安全组规则。
resource "alicloud_security_group_rule" "allow_all_tcp" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 1
  security_group_id = alicloud_security_group.security.id
  cidr_ip           = "0.0.0.0/0"
}

#本示例以创建最大实例数为100的伸缩组为例。
resource "alicloud_ess_scaling_group" "group" {
  scaling_group_name = "tf_test_scalinggroup"
  min_size           = 0
  max_size           = 100
  vswitch_ids        = [alicloud_vswitch.vsw.id]
}

#本示例以创建ECS类型的伸缩配置为例。
resource "alicloud_ess_scaling_configuration" "configuration" {
  scaling_group_id           = alicloud_ess_scaling_group.group.id
  instance_type              = var.instance_type
  image_id                   = var.image_id
  security_group_id          = alicloud_security_group.security.id
  scaling_configuration_name = "tf_test_scalingconfiguration"
  system_disk_category       = "cloud_essd"
  spot_strategy              = "SpotWithPriceLimit"
  active                     = true
  force_delete               = true
}

#创建伸缩规则
resource "alicloud_ess_scaling_rule" "rule" {
  scaling_group_id = alicloud_ess_scaling_group.group.id
  adjustment_type  = "QuantityChangeInCapacity"
  adjustment_value = 1
}
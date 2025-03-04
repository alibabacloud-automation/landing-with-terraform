# 定义一个变量region，默认值为"cn-beijing"，用于指定阿里云区域
variable "region" {
  default = "cn-beijing"
}

# 配置阿里云provider，使用变量region中定义的区域
provider "alicloud" {
  region = var.region
}

# 定义一个字符串类型的变量instance_type，默认值为"ecs.e-c1m1.large"，用于指定ECS实例类型
variable "instance_type" {
  type    = string
  default = "ecs.e-c1m1.large"
}

# 使用数据源查询可用区信息，通过指定的实例类型、资源创建类型（如VSwitch）以及磁盘种类来过滤结果
data "alicloud_zones" "default" {
  available_instance_type     = var.instance_type
  available_resource_creation = "VSwitch"
  available_disk_category     = "cloud_essd"
}

# 定义一个变量vpc_cidr_block，默认值为"172.16.0.0/16"，用于指定VPC的CIDR块
variable "vpc_cidr_block" {
  default = "172.16.0.0/16"
}

# 定义一个变量vsw_cidr_block，默认值为"172.16.0.0/24"，用于指定VSwitch的CIDR块
variable "vsw_cidr_block" {
  default = "172.16.0.0/24"
}

# 生成一个介于10000到99999之间的随机整数，用于确保某些资源名称的唯一性
resource "random_integer" "default" {
  min = 10000
  max = 99999
}

# 创建名为vpc-test的VPC，并使用随机整数确保名称唯一性
resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc-test_${random_integer.default.result}"
  cidr_block = var.vpc_cidr_block
}

# 创建安全组，名称包含随机整数以保证唯一性，并关联至上述VPC
resource "alicloud_security_group" "group" {
  security_group_name = "test_${random_integer.default.result}" # 替换了这里的字段名
  vpc_id              = alicloud_vpc.vpc.id
}

# 创建一条允许所有TCP流量进入的安全组规则，与之前创建的安全组关联
resource "alicloud_security_group_rule" "allow_all_tcp" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet" # 修改了这里，将nic_type改为'intranet'
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

# 创建VSwitch，名称中包含随机整数以确保唯一性，并与VPC、可用区关联
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.vsw_cidr_block
  zone_id      = data.alicloud_zones.default.zones[0].id
  vswitch_name = "vswitch-test-${random_integer.default.result}"
}

# 创建ECS实例，设置多个参数如可用区、安全组、实例类型等，并使用随机整数保证实例名称的唯一性
resource "alicloud_instance" "instance" {
  availability_zone          = data.alicloud_zones.default.zones[0].id
  security_groups            = [alicloud_security_group.group.id]
  instance_type              = var.instance_type
  system_disk_category       = "cloud_essd"
  system_disk_name           = "test_foo_system_disk_${random_integer.default.result}"
  system_disk_description    = "test_foo_system_disk_description"
  image_id                   = "aliyun_2_1903_x64_20G_alibase_20240628.vhd"
  instance_name              = "test_ecs_${random_integer.default.result}"
  vswitch_id                 = alicloud_vswitch.vswitch.id
  internet_max_bandwidth_out = 10
  password                   = "Terraform@Example" # 用户根据自己实际情况修改
}
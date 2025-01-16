# 定义区域变量，默认为 "cn-guangzhou"
variable "region" {
  default = "cn-guangzhou"
}
# 配置阿里云提供者，并使用上面定义的区域变量
provider "alicloud" {
  region = var.region
}
# 定义实例类型变量，默认为 "ecs.e-c1m1.large"
variable "instance_type" {
  type    = string
  default = "ecs.e-c1m1.large"
}
# 获取可用区信息的数据源，确保选择的实例类型、资源创建类型和磁盘类别都可用
data "alicloud_zones" "default" {
  available_instance_type     = var.instance_type
  available_resource_creation = "VSwitch"
  available_disk_category     = "cloud_essd"
}
# 定义VPC的CIDR块，默认为 "172.16.0.0/16"
variable "vpc_cidr_block" {
  default = "172.16.0.0/16"
}
# 定义VSwitch的CIDR块，默认为 "172.16.0.0/24"
variable "vsw_cidr_block" {
  default = "172.16.0.0/24"
}
# 定义镜像ID变量，默认为一个示例镜像ID
variable "image_id" {
  default = "centos_7_9_x64_20G_alibase_20240628.vhd"
}
# 定义实例默认登陆密码
variable "password" {
  default = "Terraform@Example"
}
# 创建一个随机整数，用于在资源名称中添加唯一性，防止资源冲突
resource "random_integer" "default" {
  min = 10000
  max = 99999
}
# 创建VPC资源，并设置名称和CIDR块
resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc-test_${random_integer.default.result}" # VPC名称包含随机数以保证唯一性
  cidr_block = var.vpc_cidr_block                          # 使用变量定义的CIDR块
}
# 创建安全组资源，并设置名称和所属VPC ID
resource "alicloud_security_group" "group" {
  name   = "test_${random_integer.default.result}" # 安全组名称包含随机数以保证唯一性
  vpc_id = alicloud_vpc.vpc.id                     # 关联到之前创建的VPC
}
# 安全组规则 - 入方向规则放行SSH（端口22）
resource "alicloud_security_group_rule" "allow_ssh" {
  type              = "ingress"                        # 规则类型：入站
  ip_protocol       = "tcp"                            # 协议类型：TCP
  policy            = "accept"                         # 策略：接受
  port_range        = "22/22"                          # 端口范围：仅22端口
  priority          = 1                                # 优先级：1
  security_group_id = alicloud_security_group.group.id # 关联到之前创建的安全组
  cidr_ip           = "0.0.0.0/0"                      # 允许所有IP地址访问
}
# 安全组规则 - 入方向规则放行HTTP（端口80）
resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"                        # 规则类型：入站
  ip_protocol       = "tcp"                            # 协议类型：TCP
  policy            = "accept"                         # 策略：接受
  port_range        = "80/80"                          # 端口范围：仅80端口
  priority          = 1                                # 优先级：1
  security_group_id = alicloud_security_group.group.id # 关联到之前创建的安全组
  cidr_ip           = "0.0.0.0/0"                      # 允许所有IP地址访问
}
# 创建vSwitch资源，并设置所属VPC、子网CIDR块、所在可用区及名称
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id                             # 关联到之前创建的VPC
  cidr_block   = var.vsw_cidr_block                              # 使用变量定义的CIDR块
  zone_id      = data.alicloud_zones.default.zones[0].id         # 使用数据源获取的第一个可用区
  vswitch_name = "vswitch-test-${random_integer.default.result}" # vSwitch名称包含随机数以保证唯一性
}
# 创建资源组ECS-HHM
resource "alicloud_resource_manager_resource_group" "ecs_admin" {
  name         = "ECS-HHM"
  display_name = "ECS Admin Resource Group"
}
# 创建ECS实例，并配置其参数，如可用区、安全组、实例类型等
resource "alicloud_instance" "instance" {
  availability_zone          = data.alicloud_zones.default.zones[0].id                 # 使用数据源获取的第一个可用区
  security_groups            = [alicloud_security_group.group.id]                      # 使用之前创建的安全组
  instance_type              = var.instance_type                                       # 使用变量定义的实例类型
  system_disk_category       = "cloud_essd"                                            # 使用ESSD云盘作为系统盘
  system_disk_name           = "test_foo_system_disk_${random_integer.default.result}" # 系统盘名称包含随机数以保证唯一性
  system_disk_description    = "test_foo_system_disk_description"                      # 系统盘描述
  image_id                   = var.image_id                                            # 使用变量定义的镜像ID
  instance_name              = "test_ecs_${random_integer.default.result}"             # 实例名称包含随机数以保证唯一性
  vswitch_id                 = alicloud_vswitch.vswitch.id                             # 使用之前创建的vSwitch
  internet_max_bandwidth_out = 10                                                      # 设置互联网出带宽最大值为10Mbps
  password                   = var.password                                            # 设置实例登录密码
  resource_group_id          = alicloud_resource_manager_resource_group.ecs_admin.id   # 指定资源组
}
# 创建RAM用户
resource "alicloud_ram_user" "example" {
  name         = "HHM-example-user"
  display_name = "HHM-Example User"
  mobile       = "86-18600001111"      # 可选，格式为国家代码-手机号码
  email        = "HHMuser@example.com" # 可选
}
# Get Alicloud Account Id
data "alicloud_account" "example" {}
resource "alicloud_resource_manager_policy_attachment" "example" {
  policy_name = "AliyunECSFullAccess"
  # 授权类型 Custom: 自定义策略  System: 系统策略
  policy_type    = "System"
  principal_name = format("%s@%s.onaliyun.com", alicloud_ram_user.example.name, data.alicloud_account.example.id)
  #IMSUser：RAM用户 IMSGroup：RAM用户组 ServiceRole：RAM角色
  principal_type    = "IMSUser"
  resource_group_id = alicloud_resource_manager_resource_group.ecs_admin.id
}
# 输出实例ID
output "instance_id" {
  value = alicloud_instance.instance.id
}
# 输出实例公网IP
output "public_ip" {
  value = alicloud_instance.instance.public_ip
}
# 输出资源组ID
output "resource_group_id" {
  value = alicloud_resource_manager_resource_group.ecs_admin.id
}


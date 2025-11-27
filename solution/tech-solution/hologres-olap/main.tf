# ------------------------------------------------------------------------------
# 核心资源定义
#
# 本文件包含了模块的核心基础设施资源
# 这里的代码负责根据输入变量来创建和配置所有云资源
# ------------------------------------------------------------------------------

# 配置阿里云提供商
provider "alicloud" {
  region = "cn-hangzhou"
}

# 创建一个随机ID
resource "random_id" "suffix" {
  byte_length = 8
}

# 定义本地变量
locals {
  common_name = "olap-analysis-${random_id.suffix.id}"
}

# 创建专有网络VPC
resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "${local.common_name}-vpc"
}

# 创建交换机VSwitch
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = var.zone_id
  vswitch_name = "${local.common_name}-vsw"
}

# 创建Hologram实例
resource "alicloud_hologram_instance" "hologram" {
  instance_type = "Standard"
  zone_id       = var.zone_id
  payment_type  = "PayAsYouGo"
  pricing_cycle = "Hour"
  cpu           = 32
  instance_name = "${local.common_name}-hologram"

  # 配置内网端点
  endpoints {
    type = "Intranet"
  }

  # 配置VPC单通道端点
  endpoints {
    vpc_id     = alicloud_vpc.vpc.id
    vswitch_id = alicloud_vswitch.vswitch.id
    type       = "VPCSingleTunnel"
  }
  # 配置互联网端点
  endpoints {
    type = "Internet"
  }
}
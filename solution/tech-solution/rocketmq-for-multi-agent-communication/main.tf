# ------------------------------------------------------------------------------
# 核心资源定义 (Main Resource Definitions)
#
# 本文件包含了模块的核心基础设施资源。
# 这里的代码负责根据输入变量来创建和配置所有云资源。
# ------------------------------------------------------------------------------

# 配置阿里云提供商 (Provider) 
provider "alicloud" {
  region = "cn-chengdu"
}

# 查询当前部署地域
data "alicloud_regions" "current_region_ds" {
  current = true
}

# 查询支持指定ECS实例规格和磁盘类型的可用区
data "alicloud_zones" "ecs_zones" {
  available_disk_category     = "cloud_essd"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.ecs_instance_type
}

# 创建一个随机ID，用于生成唯一的资源名称后缀，避免命名冲突
resource "random_string" "suffix" {
  length  = 8
  lower   = true
  upper   = false
  numeric = false
  special = false
}

# 定义一个局部变量，将随机ID用作通用名称后缀
locals {
  common_name = random_string.suffix.id
  region      = data.alicloud_regions.current_region_ds.regions.0.id
}

# 创建一个专有网络（VPC），为云资源提供一个隔离的网络环境
resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "vpc-${local.common_name}"
}

# 创建一个交换机（VSwitch），用于在VPC内划分一个子网
resource "alicloud_vswitch" "ecs_vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.1.0/24"
  zone_id      = data.alicloud_zones.ecs_zones.zones[0].id
  vswitch_name = "ecs-vswitch-${local.common_name}"
}

# 创建一个安全组，作为虚拟防火墙来控制ECS实例的网络访问
resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "sg-${local.common_name}"
}

# 查询可用的阿里云镜像
data "alicloud_images" "default" {
  name_regex  = "^aliyun_3_x64_20G_alibase_.*"
  most_recent = true
  owners      = "system"
}

# 创建一台ECS实例（云服务器）
resource "alicloud_instance" "ecs_instance" {
  instance_name              = "ecs-${local.common_name}"
  image_id                   = data.alicloud_images.default.images[0].id
  instance_type              = var.ecs_instance_type
  system_disk_category       = "cloud_essd"
  security_groups            = [alicloud_security_group.security_group.id]
  vswitch_id                 = alicloud_vswitch.ecs_vswitch.id
  password                   = var.ecs_instance_password
  internet_max_bandwidth_out = 5
}


# 创建一个RocketMQ实例
resource "alicloud_rocketmq_instance" "rocketmq" {
  product_info {
    msg_process_spec       = "rmq.s2.2xlarge"
    message_retention_time = "70"
    send_receive_ratio     = "0.5"
  }

  sub_series_code = "cluster_ha"
  series_code     = "standard"
  payment_type    = "PayAsYouGo"
  instance_name   = "ROCKETMQ5-${local.common_name}"
  service_code    = "rmq"

  network_info {
    vpc_info {
      vpc_id = alicloud_vpc.vpc.id
      vswitches {
        vswitch_id = alicloud_vswitch.ecs_vswitch.id
      }
    }
    internet_info {
      internet_spec = "disable"
      flow_out_type = "uninvolved"
    }
  }

  acl_info {
    acl_types             = ["default", "apache_acl"]
    default_vpc_auth_free = false
  }

  tags = {
    version_capability = "lite-topic"
  }

}
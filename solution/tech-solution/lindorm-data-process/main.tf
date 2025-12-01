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

# 生成一个随机字符串
# Generate a random string.
resource "random_string" "lowercase" {
  length  = 8
  special = false
  upper   = false
  numeric = false
}

# 定义本地变量
locals {
  common_name     = "lindorm-demo-${random_string.lowercase.result}"
  sorted_zone_ids = sort(data.alicloud_zones.default.ids)
  max_zone_id     = local.sorted_zone_ids[length(local.sorted_zone_ids) - 1]

  # 定义 ECS 启动命令 
  ecs_command = <<-SHELL
          #!/bin/bash
          function log_info() {
              printf "%s [INFO] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$1"
          }
          function log_error() {
              printf "%s [ERROR] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$1"
          }
          function debug_exec(){
              local cmd="$@"
              log_info "$cmd"
              eval "$cmd"
              ret=$?
              echo ""
              log_info "$cmd, exit code: $ret"
              return $ret
          }
          function init_work(){
            yum upgrade & yum install -y python3 cryptography==3.4.8
            wget -O lindorm-cli-linux-latest.tar.gz https://tsdbtools.oss-cn-hangzhou.aliyuncs.com/lindorm-cli-linux-latest.tar.gz
            tar zxvf lindorm-cli-linux-latest.tar.gz
          }
          debug_exec init_work
            SHELL
}

# 查询可用区
data "alicloud_zones" "default" {
  available_disk_category = "cloud_essd"
  available_instance_type = var.instance_type
}

# 创建专有网络VPC
resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "vpc-${local.common_name}"
}

# 创建交换机VSwitch
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = local.max_zone_id
  vswitch_name = "vsw-${local.common_name}"
}

# 创建安全组
resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "sg-${local.common_name}"
}

# 查询最新的镜像
data "alicloud_images" "alinux3" {
  name_regex  = "^aliyun_3_x64_*"
  owners      = "system"
  most_recent = true
  status      = "Available"
}

# 创建ECS实例
resource "alicloud_instance" "ecs_instance" {
  availability_zone          = local.max_zone_id
  vpc_id                     = alicloud_vpc.vpc.id
  vswitch_id                 = alicloud_vswitch.vswitch.id
  security_groups            = [alicloud_security_group.security_group.id]
  password                   = var.ecs_instance_password
  instance_type              = var.instance_type
  instance_name              = "ecs-${local.common_name}"
  system_disk_category       = "cloud_essd"
  image_id                   = data.alicloud_images.alinux3.images[0].id
  internet_max_bandwidth_out = 5
}

# 创建Lindorm实例
resource "alicloud_lindorm_instance" "lindorm_instance" {
  instance_storage            = 160
  zone_id                     = local.max_zone_id
  payment_type                = "PayAsYouGo"
  vswitch_id                  = alicloud_vswitch.vswitch.id
  vpc_id                      = alicloud_vpc.vpc.id
  search_engine_specification = "lindorm.g.xlarge"
  search_engine_node_count    = 2
  table_engine_specification  = "lindorm.g.xlarge"
  table_engine_node_count     = 2
  disk_category               = "cloud_efficiency"
  instance_name               = "lindorm-${local.common_name}"
}

# 定义ECS命令资源
resource "alicloud_ecs_command" "deploy_application_on_ecs_alicloud_ecs_command" {
  type            = "RunShellScript"
  timeout         = 300
  command_content = base64encode(local.ecs_command)
  name            = "auto-75ca2a13"
  working_dir     = "/root"
}

# 创建ECS命令调用
resource "alicloud_ecs_invocation" "deploy_application_on_ecs_alicloud_ecs_invocation" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id  = alicloud_ecs_command.deploy_application_on_ecs_alicloud_ecs_command.id
  timeouts {
    create = "60m"
  }
}
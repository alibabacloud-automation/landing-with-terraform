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

# 创建随机ID用于资源命名
resource "random_id" "suffix" {
  byte_length = 8
}

# 定义本地变量common_name
locals {
  common_name = "SelectDB-${random_id.suffix.id}"
  ecs_command = <<SHELL
#!/bin/bash
cd /root
export ROS_DEPLOY=true
wget https://help-static-aliyun-doc.aliyuncs.com/install-script/selectdb-observability/yc_log_demo_2.0.1.tar.gz
tar -zxvf yc_log_demo_2.0.1.tar.gz
cd /root/log_demo
bash install.sh
sudo chown -R root:root /root/log_demo
SHELL
}

# 查询可用区
data "alicloud_zones" "default" {
  available_disk_category     = "cloud_essd"
  available_instance_type     = var.instance_type
}

# 创建VPC
resource "alicloud_vpc" "vpc_select" {
  cidr_block = "192.168.0.0/16"
  vpc_name       = "${local.common_name}-vpc"
}

# 创建VSwitch
resource "alicloud_vswitch" "vsw_select" {
  vpc_id     = alicloud_vpc.vpc_select.id
  zone_id    = data.alicloud_zones.default.ids[0]
  cidr_block = "192.168.0.0/24"
  vswitch_name       = "${local.common_name}-vsw"
}

# 创建安全组
resource "alicloud_security_group" "sg_select" {
  security_group_name   = "${local.common_name}-sg"
  vpc_id = alicloud_vpc.vpc_select.id
}

# 允许SSH访问
resource "alicloud_security_group_rule" "allow_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.sg_select.id
  cidr_ip           = "0.0.0.0/0"
}

# 允许HTTP访问
resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "8080/8080"
  priority          = 1
  security_group_id = alicloud_security_group.sg_select.id
  cidr_ip           = "0.0.0.0/0"
}

# 获取阿里云官方镜像
data "alicloud_images" "image_id" {
  name_regex  = "^aliyun_3_9_x64_20G*"
  owners      = "system"  # 官方镜像
  most_recent = true      # 获取最新版本
}

# 创建ECS实例
resource "alicloud_instance" "ecs_instance" {
  vpc_id                     = alicloud_vpc.vpc_select.id
  vswitch_id                 = alicloud_vswitch.vsw_select.id
  security_groups = [alicloud_security_group.sg_select.id]
  image_id                   = data.alicloud_images.image_id.images[0].id
  instance_name              = "${local.common_name}-ecs"
  instance_type              = var.instance_type
  system_disk_category       = "cloud_essd"
  system_disk_size           = 100
  internet_max_bandwidth_out = 10
  password                   = var.ecs_instance_password
}

# 创建SelectDB实例
resource "alicloud_selectdb_db_instance" "selectdb_instance" {
  vpc_id                  = alicloud_vpc.vpc_select.id
  zone_id                 = data.alicloud_zones.default.ids[0]
  vswitch_id              = alicloud_vswitch.vsw_select.id
  db_instance_description = "${local.common_name}-selectdb"
  db_instance_class       = var.instance_class
  cache_size              = 100
  payment_type            = "PayAsYouGo"
  engine_minor_version    = var.selectdb_engine_version
  admin_pass              = var.db_password
  desired_security_ip_lists {
    group_name            = "default"
    security_ip_list      = "192.168.0.0/16"
  }
}

# 创建ECS命令资源
resource "alicloud_ecs_command" "run_tpcc_alicloud_ecs_command" {
  name             = "commond_install"
  description      = "commond_install_description"
  type             = "RunShellScript"
  command_content  = base64encode(local.ecs_command)
  timeout          = 3600
  working_dir      = "/root"
}

# 创建ECS命令调用资源
resource "alicloud_ecs_invocation" "run_tpcc_alicloud_ecs_invocation" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id = alicloud_ecs_command.run_tpcc_alicloud_ecs_command.id
  depends_on = [alicloud_selectdb_db_instance.selectdb_instance]
  timeouts {
    create = "60m"
  }
}
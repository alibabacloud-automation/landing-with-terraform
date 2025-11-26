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
  common_name = "rdsmysql2ck-${random_id.suffix.id}"
  # 选择第一个共同可用区（或根据逻辑选择）
  database_class = {
    RDS={
        "8C32G"= "mysql.x4.xlarge.2c"
        "16C64G"= "mysql.x4.2xlarge.2c"
        "32C128G"= "mysql.x4.4xlarge.2c"
        "64C256G"= "mysql.x4.8xlarge.2c"
    }
    ClickHouse={
        "8C32G"="S8"
        "16C64G"= "S16"
        "32C128G"= "S32"
        "64C256G"= "S64"
    }
  }
  ecs_command = <<SHELL
#!/bin/bash
echo "export RDS_URL=${alicloud_db_instance.rds_instance.connection_string}" >> ~/.bash_profile
echo "export RDS_USERNAME=${var.rds_db_user}" >> ~/.bash_profile
echo "export RDS_PASSWORD=${var.db_password}" >> ~/.bash_profile
echo "export ROS_DEPLOY=true" >> ~/.bash_profile
source ~/.bash_profile
curl -fsSL https://help-static-aliyun-doc.aliyuncs.com/install-script/rdsclickhouse-htap/install_htap.sh|sh
SHELL
}

# 查询满足条件的可用区
data "alicloud_db_zones" "zones_ids" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
}

# 创建专有网络VPC
resource "alicloud_vpc" "vpc" {
  vpc_name = "vpc_${local.common_name}"
  cidr_block = "192.168.0.0/16"
}

# 创建交换机VSwitch
resource "alicloud_vswitch" "vswitch" {     
  vpc_id = alicloud_vpc.vpc.id
  zone_id = data.alicloud_db_zones.zones_ids.ids.1
  cidr_block = "192.168.0.0/24"
  vswitch_name = "vswitch_${local.common_name}"
}

# 创建安全组
resource "alicloud_security_group" "security_group" {
  vpc_id = alicloud_vpc.vpc.id
}

# 创建RDS数据库实例
resource "alicloud_db_instance" "rds_instance" {
  instance_name = "rdsmysql_${local.common_name}"
  engine = "MySQL"
  instance_storage = 100
  engine_version = "8.0"
  category = "HighAvailability"
  db_instance_storage_type = "cloud_essd"
  security_ips = ["0.0.0.0/0"]
  vpc_id = alicloud_vpc.vpc.id
  zone_id = data.alicloud_db_zones.zones_ids.ids.1
  vswitch_id = alicloud_vswitch.vswitch.id
  instance_charge_type = "Postpaid"
  instance_type = lookup(local.database_class["RDS"], var.db_instance_class, "rds.mysql.s1.small")
}

# 创建数据库
resource "alicloud_db_database" "database" {
  character_set   = "utf8mb4"
  instance_id     = alicloud_db_instance.rds_instance.id
  name            = "tpcc"
  description     = "tpcc_${local.common_name}"
}

# 创建数据库账号
resource "alicloud_db_account" "default" {
  db_instance_id      = alicloud_db_instance.rds_instance.id
  account_name        = var.rds_db_user
  account_password    = var.db_password
  account_type        = "Super"
}

# 创建ClickHouse数据库集群
resource "alicloud_click_house_db_cluster" "click_house" {
  db_cluster_version      = "23.8"
  category                = "Basic"
  db_cluster_class        = lookup(local.database_class["ClickHouse"], var.db_instance_class, "rds.mysql.s1.small")
  db_cluster_network_type = "vpc"
  db_node_group_count     = "1"
  payment_type            = "PayAsYouGo"
  db_node_storage         = "100"
  storage_type            = "cloud_essd"
  vswitch_id              = alicloud_vswitch.vswitch.id
  vpc_id                  = alicloud_vpc.vpc.id
  zone_id                 = data.alicloud_db_zones.zones_ids.ids.1
  db_cluster_description  = "ck_${local.common_name}"
}

# 创建ClickHouse数据库账号
resource "alicloud_click_house_account" "default" {
  db_cluster_id       = alicloud_click_house_db_cluster.click_house.id
  account_name        = var.click_house_user
  account_password    = var.db_password
  type                = "Super"
}

# 获取最新的CentOS 7.9系统镜像
data "alicloud_images" "centos_7_9" {
  name_regex  = "^centos_7_9_x64_*"
  owners      = "system"  # 官方镜像
  most_recent = true      # 获取最新版本
}

# 创建ECS实例
resource "alicloud_instance" "ecs_instance" {
  availability_zone    = data.alicloud_db_zones.zones_ids.ids.1
  vpc_id               = alicloud_vpc.vpc.id
  vswitch_id           = alicloud_vswitch.vswitch.id
  internet_max_bandwidth_out = 5
  security_groups      = [alicloud_security_group.security_group.id]
  password             = var.ecs_instance_password
  instance_type        = var.ecs_instance_type
  system_disk_category = "cloud_essd"
  image_id             = data.alicloud_images.centos_7_9.images[0].id
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
  depends_on = [alicloud_db_instance.rds_instance]
  timeouts {
    create = "60m"
  }
}
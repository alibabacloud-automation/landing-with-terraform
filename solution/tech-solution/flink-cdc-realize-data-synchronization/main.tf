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

resource "random_string" "lowercase" {
  length  = 8
  special = false
  upper   = false
  numeric = false
}

# 本地变量，资源名称前缀
locals {
  common_name = "flink-cdc-${random_string.lowercase.result}"
}

# 查询可用区
data "alicloud_db_zones" "zones_ids" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
}

# 启用OSS服务
data "alicloud_oss_service" "open_oss" {
  enable = "On"
}

# 创建VPC
resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc-${local.common_name}"
  cidr_block = "192.168.0.0/16"
}

# 创建交换机VSwitch
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.1.0/24"
  vswitch_name = "test-vsw"
  zone_id      = data.alicloud_db_zones.zones_ids.ids.1
}

# 创建RDS实例
resource "alicloud_db_instance" "rdsdbinstance" {
  zone_id                  = data.alicloud_db_zones.zones_ids.ids.1
  vpc_id                   = alicloud_vpc.vpc.id
  vswitch_id               = alicloud_vswitch.vswitch.id
  instance_type            = var.dbinstance_class
  instance_storage         = 50
  engine                   = "MySQL"
  engine_version           = "8.0"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
  security_ips             = ["192.168.0.0/16"]
  released_keep_policy     = "None"
}

# 创建RDS账户
resource "alicloud_rds_account" "account" {
  db_instance_id   = alicloud_db_instance.rdsdbinstance.id
  account_type     = "Super"
  account_password = var.db_password
  account_name     = var.db_user_name
}

# 创建数据库
resource "alicloud_db_database" "db_base1" {
  instance_id   = alicloud_db_instance.rdsdbinstance.id
  character_set = "utf8"
  name          = "tpc_ds"
}

resource "alicloud_db_database" "db_base2" {
  instance_id   = alicloud_db_instance.rdsdbinstance.id
  character_set = "utf8"
  name          = "user_db1"
}

resource "alicloud_db_database" "db_base3" {
  instance_id   = alicloud_db_instance.rdsdbinstance.id
  character_set = "utf8"
  name          = "user_db2"
}

resource "alicloud_db_database" "db_base4" {
  instance_id   = alicloud_db_instance.rdsdbinstance.id
  character_set = "utf8"
  name          = "user_db3"
}

# 创建OSS存储桶
resource "alicloud_oss_bucket" "bucket" {
  bucket          = "${var.bucket_name}-${random_string.lowercase.result}"
  force_destroy = true
}

# 创建OSS存储桶对象
resource "alicloud_oss_bucket_object" "directory_name" {
  bucket        = alicloud_oss_bucket.bucket.bucket
  key           = "${replace(trimspace(var.directory_name), "/$", "")}/"
  content       = "Directory placeholder. Managed by Terraform."
  acl           = "private"
}

# 创建Flink实例
resource "alicloud_realtime_compute_vvp_instance" "flink_instance" {
  zone_id                  = data.alicloud_db_zones.zones_ids.ids.1
  vpc_id                   = alicloud_vpc.vpc.id
  vswitch_ids              = [
    alicloud_vswitch.vswitch.id
  ]
  vvp_instance_name        = var.flink_instance_name
  payment_type             = "PayAsYouGo"
  storage {
    oss {
      bucket = alicloud_oss_bucket.bucket.bucket
    }
  }
}
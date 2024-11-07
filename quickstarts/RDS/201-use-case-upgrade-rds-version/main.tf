variable "region" {
  default = "cn-heyuan"
}

provider "alicloud" {
  region = var.region
}

variable "zone_id" {
  default = "cn-heyuan-b"
}

variable "instance_type" {
  default = "pg.n2.2c.2m"
}

variable "target_minor_version" {
  default = "rds_postgres_1300_20240229"
}

# 创建VPC
resource "alicloud_vpc" "main" {
  vpc_name   = "alicloud"
  cidr_block = "172.16.0.0/16"
}

# 创建交换机
resource "alicloud_vswitch" "main" {
  vpc_id     = alicloud_vpc.main.id
  cidr_block = "172.16.192.0/20"
  zone_id    = var.zone_id
}

# 创建RDS PostgreSQL实例
resource "alicloud_db_instance" "instance" {
  engine               = "PostgreSQL"
  engine_version       = "13.0"
  instance_type        = var.instance_type
  instance_storage     = "30"
  instance_charge_type = "Postpaid"
  vswitch_id           = alicloud_vswitch.main.id
  target_minor_version = var.target_minor_version
  # 升级示例内核小版本
  # target_minor_version = "rds_postgres_1300_20240830"
}

# 升级示例大版本
#resource "alicloud_rds_upgrade_db_instance" "upgrade" {
#  source_db_instance_id    = alicloud_db_instance.instance.id
#  target_major_version     = "14.0"
#  db_instance_class        = "pg.n2.2c.2m"
#  db_instance_storage      = "50"
#  instance_network_type    = "VPC"
#  db_instance_storage_type = "cloud_essd"
#  collect_stat_mode        = "After"
#  switch_over              = "false"
#  payment_type             = "PayAsYouGo"
#  vswitch_id               = alicloud_vswitch.main.id
#}
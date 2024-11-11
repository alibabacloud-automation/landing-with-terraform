variable "region" {
  default = "cn-shenzhen"
}

variable "zone_id" {
  default = "cn-shenzhen-c"
}

variable "instance_type" {
  default = "pg.n2.2c.2m"
}

variable "target_minor_version" {
  default = "rds_postgres_1300_20240830"
}

provider "alicloud" {
  region = var.region
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
  # 开启SQL审计（创建完RDS PostgreSQL实例后添加如下代码）
  sql_collector_status = "Enabled"
  # 关闭SQL审计
  # sql_collector_status = "Disabled"
}                    
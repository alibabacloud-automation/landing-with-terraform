variable "region" {
  default = "cn-heyuan"
}

variable "zone_id" {
  default = "cn-heyuan-b"
}

variable "instance_type" {
  default = "pg.n2.2c.2m"
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
}

# 创建数据库
resource "alicloud_db_database" "db" {
  instance_id = alicloud_db_instance.instance.id
  name        = "tf_database_test"
}

#申请外网地址
resource "alicloud_db_connection" "extranet" {
  instance_id = alicloud_db_instance.instance.id
  port        = "5432"
  # 修改外网地址
  connection_prefix = "pgtest"
}
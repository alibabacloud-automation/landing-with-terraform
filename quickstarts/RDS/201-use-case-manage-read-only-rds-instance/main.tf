variable "region" {
  default = "cn-heyuan"
}

variable "name" {
  default = "tf-example"
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

# 创建RDS PostgreSQL只读实例
resource "alicloud_db_readonly_instance" "default" {
  master_db_instance_id = alicloud_db_instance.instance.id
  zone_id               = alicloud_db_instance.instance.zone_id
  engine_version        = alicloud_db_instance.instance.engine_version
  instance_type         = "pgro.n4.2c.1m"
  instance_storage      = "50"
  instance_name         = "${alicloud_db_instance.instance.id}ro"
  vswitch_id            = alicloud_vswitch.main.id
}
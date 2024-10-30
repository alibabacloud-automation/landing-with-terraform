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

resource "time_static" "example" {}

# 创建RDS PostgreSQL实例
resource "alicloud_db_instance" "instance" {
  engine               = "PostgreSQL"
  engine_version       = "13.0"
  instance_type        = var.instance_type
  instance_storage     = "30"
  instance_charge_type = "Postpaid"
  vswitch_id           = alicloud_vswitch.main.id
  # 临时关闭主备自动切换（注意manual_ha_time日期时间设置需要大于当前日期时间）
  ha_config      = "Manual"
  manual_ha_time = formatdate("YYYY-MM-DD'T'hh:mm:ss'Z'", timeadd(time_static.example.rfc3339, "1h"))
}                       
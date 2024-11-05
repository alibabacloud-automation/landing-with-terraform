variable "region" {
  default = "cn-hangzhou"
}

provider "alicloud" {
  region = var.region
}

variable "zone_id" {
  default = "cn-hangzhou-b"
}

variable "instance_type" {
  default = "pg.n2.2c.2m"
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
  depends_on = [alicloud_vpc.main]
}

# 创建RDS PostgreSQL实例
resource "alicloud_db_instance" "instance" {
  engine               = "PostgreSQL"
  engine_version       = "13.0"
  instance_type        = var.instance_type
  instance_storage     = "30"
  instance_charge_type = "Postpaid"
  vswitch_id           = alicloud_vswitch.main.id
  # 修改实例名称
  # instance_name    = "terraformtest"
  # 修改实例配置（以修改RDS PostgreSQL实例的存储空间为50 GB为例）
  # instance_storage = "50"
  # 设置存储空间自动扩容
  # storage_auto_scale = "Enable"
  # storage_threshold = "30"
  # storage_upper_bound = "100"
  # 修改实例可维护时间段
  # maintain_time    = "05:00Z-06:00Z"
  # 修改实例资源组
  # resource_group_id = "rg-****"
  # 修改实例可用性检测方式（仅高可用实例）
  # tcp_connection_type = "SHORT"
  # 如果不需要创建VPC和交换机，使用已有的VPC和交换机
  # vswitch_id       = "vsw-****"
  # 创建多个配置相同的RDS PostgreSQL实例，x为需要创建的实例数量
  #count = x
}
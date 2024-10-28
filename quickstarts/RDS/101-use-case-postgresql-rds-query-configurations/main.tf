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
}

# 查询可用区资源
data "alicloud_db_zones" "queryzones" {
  instance_charge_type     = "PostPaid"
  engine                   = "PostgreSQL"
  db_instance_storage_type = "cloud_essd"
}

# 询可购买的实例规格
data "alicloud_db_instance_classes" "queryclasses" {
  instance_charge_type     = "PostPaid"
  engine                   = "PostgreSQL"
  db_instance_storage_type = "cloud_essd"
}

# 查询地域信息
data "alicloud_regions" "query_regions" {
}

# 查询实例列表
data "alicloud_db_instances" "queryinstances" {
}

# 查询指定实例
data "alicloud_db_instances" "queryinstance" {
  ids = [alicloud_db_instance.instance.id]
  # 查询指定地域（环境变量中设置的地域）下所有实例
  # ids  = []
  engine = "PostgreSQL"
}
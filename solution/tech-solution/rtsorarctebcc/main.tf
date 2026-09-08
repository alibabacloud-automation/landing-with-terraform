locals {
  db_name      = "demodb"
  dts_job_name = "mysql2redis_dts"
}

data "alicloud_regions" "default" {
  current = true
}

data "alicloud_kvstore_zones" "default" {
  instance_charge_type = "PostPaid"
  engine               = "Redis"
  product_type         = "OnECS"

}

data "alicloud_db_instance_classes" "default" {
  zone_id                  = data.alicloud_kvstore_zones.default.zones.0.id
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "HighAvailability"
  db_instance_storage_type = "cloud_essd"
}
resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "vswitch" {
  vpc_id     = alicloud_vpc.vpc.id
  cidr_block = "192.168.0.0/24"
  zone_id    = data.alicloud_kvstore_zones.default.zones.0.id
}

resource "alicloud_db_instance" "rds" {
  engine           = "MySQL"
  engine_version   = "8.0"
  instance_type    = data.alicloud_db_instance_classes.default.instance_classes.0.instance_class
  instance_storage = 100
  vswitch_id       = alicloud_vswitch.vswitch.id
  security_ips     = ["192.168.0.0/16"]
  category         = "HighAvailability"
}

# 创建数据库账号
resource "alicloud_db_account" "account" {
  db_instance_id   = alicloud_db_instance.rds.id
  account_name     = var.rds_db_user
  account_password = var.db_password
  account_type     = "Normal"
}

# 创建数据库
resource "alicloud_db_database" "database" {
  instance_id   = alicloud_db_instance.rds.id
  data_base_name = local.db_name
  character_set = "utf8mb4"
}

resource "alicloud_kvstore_instance" "redis" {
  instance_class = var.redis_instance_class
  vswitch_id     = alicloud_vswitch.vswitch.id
  security_ips   = ["192.168.0.0/16"]
  password       = var.redis_password
  engine_version = "6.0"
  zone_id        = data.alicloud_kvstore_zones.default.zones.0.id
}

resource "alicloud_dts_synchronization_instance" "dts" {
  payment_type                     = "PayAsYouGo"
  source_endpoint_engine_name      = "MySQL"
  destination_endpoint_engine_name = "Redis"
  instance_class                   = "small"
  source_endpoint_region           = data.alicloud_regions.default.regions.0.id
  destination_endpoint_region      = data.alicloud_regions.default.regions.0.id
  sync_architecture                = "oneway"
}

resource "alicloud_dts_synchronization_job" "job" {
  dts_instance_id                    = alicloud_dts_synchronization_instance.dts.id
  dts_job_name                       = var.dts_job_name
  source_endpoint_region             = data.alicloud_regions.default.regions.0.id
  source_endpoint_engine_name        = "MySQL"
  source_endpoint_instance_type      = "RDS"
  source_endpoint_instance_id        = alicloud_db_instance.rds.id
  source_endpoint_user_name          = var.rds_db_user
  source_endpoint_password           = var.db_password
  source_endpoint_database_name      = local.db_name
  destination_endpoint_engine_name   = "REDIS"
  destination_endpoint_instance_type = "REDIS"
  destination_endpoint_instance_id   = alicloud_kvstore_instance.redis.id
  destination_endpoint_password      = var.redis_password
  db_list = jsonencode({
    db_name = { name = local.db_name, all = true }
  })
  structure_initialization = false
  data_initialization      = true
  data_synchronization     = true
}
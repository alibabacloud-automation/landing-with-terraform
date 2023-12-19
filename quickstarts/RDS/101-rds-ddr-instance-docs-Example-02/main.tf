provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tf-example"
}

data "alicloud_db_zones" "default" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  db_instance_storage_type = "local_ssd"
  category                 = "HighAvailability"
}

data "alicloud_db_instance_classes" "default" {
  zone_id                  = data.alicloud_db_zones.default.ids.0
  engine                   = "MySQL"
  engine_version           = "8.0"
  db_instance_storage_type = "local_ssd"
  category                 = "HighAvailability"
}
data "alicloud_rds_cross_regions" "regions" {
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "172.16.0.0/16"
}
resource "alicloud_vswitch" "default" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_db_zones.default.ids.0
  vswitch_name = var.name
}

resource "alicloud_db_instance" "default" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_type            = data.alicloud_db_instance_classes.default.instance_classes.0.instance_class
  instance_storage         = data.alicloud_db_instance_classes.default.instance_classes.0.storage_range.min
  instance_charge_type     = "Postpaid"
  category                 = "HighAvailability"
  instance_name            = var.name
  vswitch_id               = alicloud_vswitch.default.id
  db_instance_storage_type = "local_ssd"
  monitoring_period        = "60"
}

resource "alicloud_rds_instance_cross_backup_policy" "default" {
  instance_id         = alicloud_db_instance.default.id
  cross_backup_region = data.alicloud_rds_cross_regions.regions.ids.0
}

data "alicloud_rds_cross_region_backups" "backups" {
  db_instance_id = alicloud_rds_instance_cross_backup_policy.default.instance_id
  start_time     = formatdate("YYYY-MM-DD'T'hh:mm'Z'", timeadd(timestamp(), "-24h"))
  end_time       = timestamp()
}

resource "alicloud_rds_ddr_instance" "default" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  db_instance_storage_type = "local_ssd"
  instance_type            = alicloud_db_instance.default.instance_type
  instance_storage         = alicloud_db_instance.default.instance_storage
  payment_type             = "PayAsYouGo"
  vswitch_id               = alicloud_vswitch.default.id
  instance_name            = var.name
  monitoring_period        = "60"
  restore_type             = "BackupTime"
  restore_time             = data.alicloud_rds_cross_region_backups.backups.backups.0.recovery_end_time
  source_region            = data.alicloud_rds_cross_region_backups.backups.backups.0.restore_regions.0
  source_db_instance_name  = data.alicloud_rds_cross_region_backups.backups.db_instance_id
}

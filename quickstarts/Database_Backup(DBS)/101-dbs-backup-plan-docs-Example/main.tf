provider "alicloud" {
  region = "cn-hangzhou"
}
variable "name" {
  default = "terraform-example"
}

data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}

data "alicloud_db_zones" "default" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "HighAvailability"
  db_instance_storage_type = "cloud_essd"
}

data "alicloud_db_instance_classes" "default" {
  zone_id                  = data.alicloud_db_zones.default.zones.0.id
  engine                   = "MySQL"
  engine_version           = "8.0"
  category                 = "HighAvailability"
  db_instance_storage_type = "cloud_essd"
  instance_charge_type     = "PostPaid"
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING"
}

data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = data.alicloud_db_zones.default.zones.0.id
}

locals {
  vswitch_id = data.alicloud_vswitches.default.ids.0
  zone_id    = data.alicloud_db_zones.default.ids.0
}

resource "alicloud_security_group" "default" {
  name   = var.name
  vpc_id = data.alicloud_vpcs.default.ids.0
}

resource "alicloud_db_instance" "default" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  db_instance_storage_type = "cloud_essd"
  instance_type            = data.alicloud_db_instance_classes.default.instance_classes.0.instance_class
  instance_storage         = data.alicloud_db_instance_classes.default.instance_classes.0.storage_range.min
  vswitch_id               = local.vswitch_id
  instance_name            = var.name
}

resource "alicloud_db_database" "default" {
  instance_id = alicloud_db_instance.default.id
  name        = "tfdatabase"
}

resource "alicloud_rds_account" "default" {
  db_instance_id   = alicloud_db_instance.default.id
  account_name     = "tfnormal000"
  account_password = "Test12345"
}

resource "alicloud_db_account_privilege" "default" {
  instance_id  = alicloud_db_instance.default.id
  account_name = alicloud_rds_account.default.account_name
  privilege    = "ReadWrite"
  db_names     = [alicloud_db_database.default.name]
}

resource "alicloud_dbs_backup_plan" "default" {
  backup_plan_name              = var.name
  payment_type                  = "PayAsYouGo"
  instance_class                = "xlarge"
  backup_method                 = "logical"
  database_type                 = "MySQL"
  database_region               = "cn-hangzhou"
  storage_region                = "cn-hangzhou"
  instance_type                 = "RDS"
  source_endpoint_instance_type = "RDS"
  resource_group_id             = data.alicloud_resource_manager_resource_groups.default.ids.0
  source_endpoint_region        = "cn-hangzhou"
  source_endpoint_instance_id   = alicloud_db_instance.default.id
  source_endpoint_user_name     = alicloud_db_account_privilege.default.account_name
  source_endpoint_password      = alicloud_rds_account.default.account_password
  backup_objects                = "[{\"DBName\":\"${alicloud_db_database.default.name}\"}]"
  backup_period                 = "Monday"
  backup_start_time             = "14:22"
  backup_storage_type           = "system"
  backup_retention_period       = 740
}
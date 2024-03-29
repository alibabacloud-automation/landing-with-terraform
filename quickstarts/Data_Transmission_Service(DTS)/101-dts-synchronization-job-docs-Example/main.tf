variable "name" {
  default = "terraform-example"
}
data "alicloud_regions" "example" {
  current = true
}
data "alicloud_db_zones" "example" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
}

data "alicloud_db_instance_classes" "example" {
  zone_id                  = data.alicloud_db_zones.example.zones.0.id
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
}

resource "alicloud_vpc" "example" {
  vpc_name   = var.name
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "example" {
  vpc_id       = alicloud_vpc.example.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_db_zones.example.zones.0.id
  vswitch_name = var.name
}

resource "alicloud_security_group" "example" {
  name   = var.name
  vpc_id = alicloud_vpc.example.id
}

resource "alicloud_db_instance" "example" {
  count                    = 2
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_type            = data.alicloud_db_instance_classes.example.instance_classes.0.instance_class
  instance_storage         = data.alicloud_db_instance_classes.example.instance_classes.0.storage_range.min
  instance_charge_type     = "Postpaid"
  instance_name            = format("%s_%d", var.name, count.index + 1)
  vswitch_id               = alicloud_vswitch.example.id
  monitoring_period        = "60"
  db_instance_storage_type = "cloud_essd"
  security_group_ids       = [alicloud_security_group.example.id]
}

resource "alicloud_rds_account" "example" {
  count            = 2
  db_instance_id   = alicloud_db_instance.example[count.index].id
  account_name     = format("example_name_%d", count.index + 1)
  account_password = format("example_password_%d", count.index + 1)
}

resource "alicloud_db_database" "example" {
  count       = 2
  instance_id = alicloud_db_instance.example[count.index].id
  name        = format("%s_%d", var.name, count.index + 1)
}

resource "alicloud_db_account_privilege" "example" {
  count        = 2
  instance_id  = alicloud_db_instance.example[count.index].id
  account_name = alicloud_rds_account.example[count.index].account_name
  privilege    = "ReadWrite"
  db_names     = [alicloud_db_database.example[count.index].name]
}

resource "alicloud_dts_synchronization_instance" "example" {
  payment_type                     = "PayAsYouGo"
  source_endpoint_engine_name      = "MySQL"
  source_endpoint_region           = data.alicloud_regions.example.regions.0.id
  destination_endpoint_engine_name = "MySQL"
  destination_endpoint_region      = data.alicloud_regions.example.regions.0.id
  instance_class                   = "small"
  sync_architecture                = "oneway"
}

resource "alicloud_dts_synchronization_job" "example" {
  dts_instance_id                    = alicloud_dts_synchronization_instance.example.id
  dts_job_name                       = var.name
  source_endpoint_instance_type      = "RDS"
  source_endpoint_instance_id        = alicloud_db_account_privilege.example.0.instance_id
  source_endpoint_engine_name        = "MySQL"
  source_endpoint_region             = data.alicloud_regions.example.regions.0.id
  source_endpoint_user_name          = alicloud_rds_account.example.0.account_name
  source_endpoint_password           = alicloud_rds_account.example.0.account_password
  destination_endpoint_instance_type = "RDS"
  destination_endpoint_instance_id   = alicloud_db_account_privilege.example.1.instance_id
  destination_endpoint_engine_name   = "MySQL"
  destination_endpoint_region        = data.alicloud_regions.example.regions.0.id
  destination_endpoint_user_name     = alicloud_rds_account.example.1.account_name
  destination_endpoint_password      = alicloud_rds_account.example.1.account_password
  db_list = jsonencode(
    {
      "${alicloud_db_database.example.0.name}" = { name = alicloud_db_database.example.1.name, all = true }
    }
  )
  structure_initialization = true
  data_initialization      = true
  data_synchronization     = true
  status                   = "Synchronizing"
}
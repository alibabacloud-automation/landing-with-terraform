provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_db_zones" "example" {
  engine                   = "PostgreSQL"
  engine_version           = "13.0"
  instance_charge_type     = "PostPaid"
  category                 = "HighAvailability"
  db_instance_storage_type = "cloud_essd"
}

data "alicloud_db_instance_classes" "example" {
  zone_id                  = data.alicloud_db_zones.example.zones.0.id
  engine                   = "PostgreSQL"
  engine_version           = "13.0"
  category                 = "HighAvailability"
  db_instance_storage_type = "cloud_essd"
  instance_charge_type     = "PostPaid"
}

data "alicloud_rds_cross_regions" "example" {
}

resource "alicloud_vpc" "example" {
  vpc_name   = "terraform-example"
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "example" {
  vpc_id       = alicloud_vpc.example.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_db_zones.example.zones.0.id
  vswitch_name = "terraform-example"
}

resource "alicloud_db_instance" "example" {
  engine                   = "PostgreSQL"
  engine_version           = "13.0"
  db_instance_storage_type = "cloud_essd"
  instance_type            = data.alicloud_db_instance_classes.example.instance_classes.0.instance_class
  instance_storage         = data.alicloud_db_instance_classes.example.instance_classes.0.storage_range.min
  instance_charge_type     = "Postpaid"
  instance_name            = "terraform-example"
  vswitch_id               = alicloud_vswitch.example.id
  monitoring_period        = "60"
}

resource "alicloud_rds_upgrade_db_instance" "example" {
  source_db_instance_id    = alicloud_db_instance.example.id
  target_major_version     = "14.0"
  db_instance_class        = alicloud_db_instance.example.instance_type
  db_instance_storage      = alicloud_db_instance.example.instance_storage
  db_instance_storage_type = alicloud_db_instance.example.db_instance_storage_type
  instance_network_type    = "VPC"
  collect_stat_mode        = "After"
  switch_over              = "false"
  payment_type             = "PayAsYouGo"
  db_instance_description  = "terraform-example"
  vswitch_id               = alicloud_vswitch.example.id
}
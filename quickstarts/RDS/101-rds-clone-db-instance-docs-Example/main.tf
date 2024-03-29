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

resource "alicloud_vpc" "example" {
  vpc_name   = "terraform-example"
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "example" {
  vpc_id       = alicloud_vpc.example.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_db_zones.example.zones.0.id
  vswitch_name = "terraform-example"
  timeouts {
    delete = "15m"
  }
}

resource "alicloud_db_instance" "example" {
  engine               = "PostgreSQL"
  engine_version       = "13.0"
  instance_type        = data.alicloud_db_instance_classes.example.instance_classes.0.instance_class
  instance_storage     = data.alicloud_db_instance_classes.example.instance_classes.0.storage_range.min
  instance_charge_type = "Postpaid"
  instance_name        = "terraform-example"
  vswitch_id           = alicloud_vswitch.example.id
  monitoring_period    = "60"
}

resource "alicloud_rds_backup" "example" {
  db_instance_id    = alicloud_db_instance.example.id
  remove_from_state = "true"
}

resource "alicloud_rds_clone_db_instance" "example" {
  source_db_instance_id    = alicloud_db_instance.example.id
  db_instance_storage_type = "cloud_essd"
  payment_type             = "PayAsYouGo"
  backup_id                = alicloud_rds_backup.example.backup_id
}
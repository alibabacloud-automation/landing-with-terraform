provider "alicloud" {
  region = "cn-beijing"
}

variable "name" {
  default = "tf-example"
}
data "alicloud_db_zones" "default" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "cluster"
  db_instance_storage_type = "cloud_essd"
}

data "alicloud_db_instance_classes" "default" {
  zone_id                  = data.alicloud_db_zones.default.ids.0
  engine                   = "MySQL"
  engine_version           = "8.0"
  category                 = "cluster"
  db_instance_storage_type = "cloud_essd"
  instance_charge_type     = "PostPaid"
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

resource "alicloud_security_group" "default" {
  name   = var.name
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_db_instance" "default" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_type            = data.alicloud_db_instance_classes.default.instance_classes.0.instance_class
  instance_storage         = data.alicloud_db_instance_classes.default.instance_classes.0.storage_range.min
  instance_charge_type     = "Postpaid"
  instance_name            = var.name
  vswitch_id               = alicloud_vswitch.default.id
  monitoring_period        = "60"
  db_instance_storage_type = "cloud_essd"
  security_group_ids       = [alicloud_security_group.default.id]
  zone_id                  = data.alicloud_db_zones.default.ids.0
  zone_id_slave_a          = data.alicloud_db_zones.default.ids.0
}

resource "alicloud_rds_db_node" "default" {
  db_instance_id = alicloud_db_instance.default.id
  class_code     = alicloud_db_instance.default.instance_type
  zone_id        = alicloud_vswitch.default.zone_id
}
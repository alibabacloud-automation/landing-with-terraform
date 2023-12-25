variable "name" {
  default = "tf_example"
}

data "alicloud_db_zones" "example" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "HighAvailability"
  db_instance_storage_type = "cloud_essd"
}

data "alicloud_db_instance_classes" "example" {
  zone_id                  = data.alicloud_db_zones.example.zones.0.id
  engine                   = "MySQL"
  engine_version           = "8.0"
  category                 = "HighAvailability"
  instance_charge_type     = "PostPaid"
  db_instance_storage_type = "cloud_essd"
}

resource "alicloud_vpc" "example" {
  vpc_name   = var.name
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "example" {
  count        = 2
  vpc_id       = alicloud_vpc.example.id
  cidr_block   = format("172.16.%d.0/24", count.index + 1)
  zone_id      = data.alicloud_db_zones.example.zones[count.index].id
  vswitch_name = format("%s_%d", var.name, count.index)
}

resource "alicloud_security_group" "example" {
  name   = var.name
  vpc_id = alicloud_vpc.example.id
}

resource "alicloud_db_instance" "example" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  category                 = "HighAvailability"
  instance_type            = data.alicloud_db_instance_classes.example.instance_classes.0.instance_class
  instance_storage         = data.alicloud_db_instance_classes.example.instance_classes.0.storage_range.min
  instance_charge_type     = "Postpaid"
  instance_name            = var.name
  vswitch_id               = join(",", alicloud_vswitch.example.*.id)
  monitoring_period        = "60"
  db_instance_storage_type = "cloud_essd"
  zone_id                  = data.alicloud_db_zones.example.zones.0.id
  zone_id_slave_a          = data.alicloud_db_zones.example.zones.1.id
}
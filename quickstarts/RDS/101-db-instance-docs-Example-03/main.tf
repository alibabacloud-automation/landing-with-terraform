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
  category                 = "Basic"
  db_instance_storage_type = "cloud_essd"
  instance_charge_type     = "PostPaid"
}

resource "alicloud_vpc" "example" {
  vpc_name   = "terraform-example"
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "example" {
  count        = 2
  vpc_id       = alicloud_vpc.example.id
  cidr_block   = format("172.16.%d.0/24", count.index + 1)
  zone_id      = data.alicloud_db_zones.example.zones[count.index].id
  vswitch_name = format("terraform_example_%d", count.index + 1)
}

resource "alicloud_security_group" "example" {
  name   = "terraform-example"
  vpc_id = alicloud_vpc.example.id
}

resource "alicloud_db_instance" "example" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_type            = data.alicloud_db_instance_classes.example.instance_classes.0.instance_class
  instance_storage         = data.alicloud_db_instance_classes.example.instance_classes.0.storage_range.min
  instance_charge_type     = "Postpaid"
  instance_name            = "terraform-example"
  vswitch_id               = join(",", alicloud_vswitch.example.*.id)
  monitoring_period        = "60"
  db_instance_storage_type = "cloud_essd"
  security_group_ids       = [alicloud_security_group.example.id]
  zone_id                  = data.alicloud_db_zones.example.zones.0.id
  zone_id_slave_a          = data.alicloud_db_zones.example.zones.1.id
}


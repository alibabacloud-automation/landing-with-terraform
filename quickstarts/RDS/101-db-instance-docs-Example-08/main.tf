variable "name" {
  default = "tf-accdbinstance"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_db_zones" "example" {
  engine                   = "SQLServer"
  engine_version           = "2019_std_sl"
  instance_charge_type     = "Serverless"
  category                 = "serverless_ha"
  db_instance_storage_type = "cloud_essd"
}

data "alicloud_db_instance_classes" "example" {
  zone_id                  = data.alicloud_db_zones.example.ids.1
  engine                   = "SQLServer"
  engine_version           = "2019_std_sl"
  category                 = "serverless_ha"
  db_instance_storage_type = "cloud_essd"
  instance_charge_type     = "Serverless"
  commodity_code           = "rds_serverless_public_cn"
}

resource "alicloud_vpc" "example" {
  vpc_name   = var.name
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "example" {
  vpc_id       = alicloud_vpc.example.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_db_zones.example.ids.1
  vswitch_name = var.name
}

resource "alicloud_db_instance" "example" {
  engine                   = "SQLServer"
  engine_version           = "2019_std_sl"
  instance_storage         = data.alicloud_db_instance_classes.example.instance_classes.0.storage_range.min
  instance_type            = data.alicloud_db_instance_classes.example.instance_classes.0.instance_class
  instance_charge_type     = "Serverless"
  instance_name            = var.name
  zone_id                  = data.alicloud_db_zones.example.ids.1
  zone_id_slave_a          = data.alicloud_db_zones.example.ids.1
  vswitch_id               = join(",", [alicloud_vswitch.example.id, alicloud_vswitch.example.id])
  db_instance_storage_type = "cloud_essd"
  category                 = "serverless_ha"
  serverless_config {
    max_capacity = 8
    min_capacity = 2
  }
}
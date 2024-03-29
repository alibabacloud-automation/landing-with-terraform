variable "name" {
  default = "tf-accdbinstance"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_db_zones" "example" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "Serverless"
  category                 = "serverless_basic"
  db_instance_storage_type = "cloud_essd"
}

data "alicloud_db_instance_classes" "example" {
  zone_id                  = data.alicloud_db_zones.example.ids.1
  engine                   = "MySQL"
  engine_version           = "8.0"
  category                 = "serverless_basic"
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
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_storage         = data.alicloud_db_instance_classes.example.instance_classes.0.storage_range.min
  instance_type            = data.alicloud_db_instance_classes.example.instance_classes.0.instance_class
  instance_charge_type     = "Serverless"
  instance_name            = var.name
  zone_id                  = data.alicloud_db_zones.example.ids.1
  vswitch_id               = alicloud_vswitch.example.id
  db_instance_storage_type = "cloud_essd"
  category                 = "serverless_basic"
  serverless_config {
    max_capacity = 8
    min_capacity = 0.5
    auto_pause   = false
    switch_force = false
  }
}
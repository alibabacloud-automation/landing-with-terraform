variable "name" {
  default = "tf-accdbinstance"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_db_zones" "example" {
  engine                   = "PostgreSQL"
  engine_version           = "14.0"
  instance_charge_type     = "Serverless"
  category                 = "serverless_basic"
  db_instance_storage_type = "cloud_essd"
}

data "alicloud_db_instance_classes" "example" {
  zone_id                  = data.alicloud_db_zones.example.ids.1
  engine                   = "PostgreSQL"
  engine_version           = "14.0"
  category                 = "serverless_basic"
  db_instance_storage_type = "cloud_essd"
  instance_charge_type     = "Serverless"
  commodity_code           = "rds_serverless_public_cn"
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}
data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = data.alicloud_db_zones.example.ids.1
}

resource "alicloud_db_instance" "example" {
  engine                   = "PostgreSQL"
  engine_version           = "14.0"
  instance_storage         = data.alicloud_db_instance_classes.example.instance_classes.0.storage_range.min
  instance_type            = data.alicloud_db_instance_classes.example.instance_classes.0.instance_class
  instance_charge_type     = "Serverless"
  instance_name            = var.name
  zone_id                  = data.alicloud_db_zones.example.ids.1
  vswitch_id               = data.alicloud_vswitches.default.ids.0
  db_instance_storage_type = "cloud_essd"
  category                 = "serverless_basic"
  serverless_config {
    max_capacity = 12
    min_capacity = 0.5
  }
}
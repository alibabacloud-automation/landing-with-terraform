variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}

data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = "cn-beijing-h"
}

resource "alicloud_gpdb_instance" "defaulttuqTmM" {
  instance_spec         = "2C8G"
  description           = var.name
  seg_node_num          = "2"
  seg_storage_type      = "cloud_essd"
  instance_network_type = "VPC"
  payment_type          = "PayAsYouGo"
  ssl_enabled           = "0"
  engine_version        = "6.0"
  zone_id               = "cn-beijing-h"
  vswitch_id            = data.alicloud_vswitches.default.ids[0]
  storage_size          = "50"
  master_cu             = "4"
  vpc_id                = data.alicloud_vpcs.default.ids.0
  db_instance_mode      = "StorageElastic"
  engine                = "gpdb"
  db_instance_category  = "Basic"
}

resource "alicloud_gpdb_account" "defaultsk1eaS" {
  account_description = "example_001"
  db_instance_id      = alicloud_gpdb_instance.defaulttuqTmM.id
  account_name        = "example_001"
  account_password    = "example_001"
}

resource "alicloud_gpdb_external_data_service" "defaultRXkfKL" {
  service_name        = var.name
  db_instance_id      = alicloud_gpdb_instance.defaulttuqTmM.id
  service_description = "myexample"
  service_spec        = "8"
}

resource "alicloud_gpdb_jdbc_data_source" "default" {
  jdbc_connection_string  = "jdbc:mysql://rm-2ze327yr44c61183c.mysql.rds.aliyuncs.com:3306/example_001"
  data_source_description = "myexample"
  db_instance_id          = alicloud_gpdb_instance.defaulttuqTmM.id
  jdbc_password           = "example_001"
  data_source_name        = alicloud_gpdb_external_data_service.defaultRXkfKL.service_name
  data_source_type        = "mysql"
  jdbc_user_name          = "example_001"
}
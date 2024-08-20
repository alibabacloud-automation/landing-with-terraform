variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "default4Mf0nY" {
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "defaultwSAVpf" {
  vpc_id     = alicloud_vpc.default4Mf0nY.id
  zone_id    = "cn-beijing-h"
  cidr_block = "192.168.1.0/24"
}

resource "alicloud_gpdb_instance" "defaultEtEzMF" {
  instance_spec         = "2C8G"
  description           = var.name
  seg_node_num          = "2"
  seg_storage_type      = "cloud_essd"
  instance_network_type = "VPC"
  db_instance_category  = "Basic"
  payment_type          = "PayAsYouGo"
  ssl_enabled           = "0"
  engine_version        = "6.0"
  zone_id               = "cn-beijing-h"
  vswitch_id            = alicloud_vswitch.defaultwSAVpf.id
  storage_size          = "50"
  master_cu             = "4"
  vpc_id                = alicloud_vpc.default4Mf0nY.id
  db_instance_mode      = "StorageElastic"
  engine                = "gpdb"
}

resource "alicloud_gpdb_instance" "defaultEY7t9t" {
  instance_spec         = "2C8G"
  description           = var.name
  seg_node_num          = "2"
  seg_storage_type      = "cloud_essd"
  instance_network_type = "VPC"
  db_instance_category  = "Basic"
  payment_type          = "PayAsYouGo"
  ssl_enabled           = "0"
  engine_version        = "6.0"
  zone_id               = "cn-beijing-h"
  vswitch_id            = alicloud_vswitch.defaultwSAVpf.id
  storage_size          = "50"
  master_cu             = "4"
  vpc_id                = alicloud_vpc.default4Mf0nY.id
  db_instance_mode      = "StorageElastic"
  engine                = "gpdb"
}

resource "alicloud_gpdb_account" "default26qpEo" {
  account_description = "example_001"
  db_instance_id      = alicloud_gpdb_instance.defaultEtEzMF.id
  account_name        = "example_001"
  account_password    = "example_001"
}

resource "alicloud_gpdb_account" "defaultwXePof" {
  account_description = "example_001"
  db_instance_id      = alicloud_gpdb_instance.defaultEY7t9t.id
  account_name        = "example_001"
  account_password    = "example_001"
}


resource "alicloud_gpdb_remote_adb_data_source" "default" {
  remote_database       = "example_001"
  manager_user_name     = "example_001"
  user_name             = "example_001"
  remote_db_instance_id = alicloud_gpdb_account.defaultwXePof.db_instance_id
  local_database        = "example_001"
  data_source_name      = "myexample"
  user_password         = "example_001"
  manager_user_password = "example_001"
  local_db_instance_id  = alicloud_gpdb_instance.defaultEtEzMF.id
}
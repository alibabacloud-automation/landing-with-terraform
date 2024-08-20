variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "defaultrple4a" {
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "defaultnYWSkl" {
  vpc_id     = alicloud_vpc.defaultrple4a.id
  zone_id    = "cn-beijing-h"
  cidr_block = "192.168.1.0/24"
}

resource "alicloud_gpdb_instance" "defaultZ7DPgB" {
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
  vswitch_id            = alicloud_vswitch.defaultnYWSkl.id
  storage_size          = "50"
  master_cu             = "4"
  vpc_id                = alicloud_vpc.defaultrple4a.id
  db_instance_mode      = "StorageElastic"
  engine                = "gpdb"
}


resource "alicloud_gpdb_external_data_service" "default" {
  service_name        = "example6"
  db_instance_id      = alicloud_gpdb_instance.defaultZ7DPgB.id
  service_description = "example"
  service_spec        = "8"
}
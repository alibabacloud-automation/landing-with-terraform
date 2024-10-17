variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "defaultNpLRa1" {
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "defaultwLA5v4" {
  vpc_id     = alicloud_vpc.defaultNpLRa1.id
  zone_id    = "cn-beijing-h"
  cidr_block = "192.168.1.0/24"
}

resource "alicloud_gpdb_instance" "defaultHKdDs3" {
  instance_spec         = "2C8G"
  seg_node_num          = "2"
  seg_storage_type      = "cloud_essd"
  instance_network_type = "VPC"
  db_instance_category  = "Basic"
  payment_type          = "PayAsYouGo"
  ssl_enabled           = "0"
  engine_version        = "6.0"
  zone_id               = "cn-beijing-h"
  vswitch_id            = alicloud_vswitch.defaultwLA5v4.id
  storage_size          = "50"
  master_cu             = "4"
  vpc_id                = alicloud_vpc.defaultNpLRa1.id
  db_instance_mode      = "StorageElastic"
  engine                = "gpdb"
  description           = var.name
}

resource "alicloud_gpdb_db_instance_ip_array" "default" {
  db_instance_ip_array_attribute = "taffyFish"
  security_ip_list               = ["12.34.56.78", "11.45.14.0", "19.19.81.0"]
  db_instance_ip_array_name      = "taffy"
  db_instance_id                 = alicloud_gpdb_instance.defaultHKdDs3.id
}
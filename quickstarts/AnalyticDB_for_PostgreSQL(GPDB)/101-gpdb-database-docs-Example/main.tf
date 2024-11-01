variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

resource "alicloud_vpc" "default35OkxY" {
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "defaultl8haQ3" {
  vpc_id     = alicloud_vpc.default35OkxY.id
  zone_id    = "cn-beijing-h"
  cidr_block = "192.168.1.0/24"
}

resource "alicloud_gpdb_instance" "defaultTC08a9" {
  instance_spec         = "2C8G"
  seg_node_num          = "2"
  seg_storage_type      = "cloud_essd"
  instance_network_type = "VPC"
  db_instance_category  = "Basic"
  payment_type          = "PayAsYouGo"
  ssl_enabled           = "0"
  engine_version        = "6.0"
  engine                = "gpdb"
  zone_id               = "cn-beijing-h"
  vswitch_id            = alicloud_vswitch.defaultl8haQ3.id
  storage_size          = "50"
  master_cu             = "4"
  vpc_id                = alicloud_vpc.default35OkxY.id
  db_instance_mode      = "StorageElastic"
}


resource "alicloud_gpdb_database" "default" {
  character_set_name = "UTF8"
  owner              = "adbpgadmin"
  description        = "go-to-the-docks-for-french-fries"
  database_name      = "seagull"
  collate            = "en_US.utf8"
  ctype              = "en_US.utf8"
  db_instance_id     = alicloud_gpdb_instance.defaultTC08a9.id
}
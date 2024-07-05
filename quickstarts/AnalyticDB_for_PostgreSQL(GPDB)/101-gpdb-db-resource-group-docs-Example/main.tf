variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "eu-central-1"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "defaultZc8RD9" {
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "defaultRv5UXt" {
  vpc_id     = alicloud_vpc.defaultZc8RD9.id
  zone_id    = data.alicloud_zones.default.zones.0.id
  cidr_block = "192.168.1.0/24"
}

resource "alicloud_gpdb_instance" "defaultJXWSlW" {
  instance_spec            = "2C8G"
  seg_node_num             = "2"
  seg_storage_type         = "cloud_essd"
  instance_network_type    = "VPC"
  db_instance_category     = "Basic"
  engine                   = "gpdb"
  resource_management_mode = "resourceGroup"
  payment_type             = "PayAsYouGo"
  ssl_enabled              = "0"
  engine_version           = "6.0"
  zone_id                  = data.alicloud_zones.default.zones.0.id
  vswitch_id               = alicloud_vswitch.defaultRv5UXt.id
  storage_size             = "50"
  master_cu                = "4"
  vpc_id                   = alicloud_vpc.defaultZc8RD9.id
  db_instance_mode         = "StorageElastic"
  description              = var.name
}


resource "alicloud_gpdb_db_resource_group" "default" {
  resource_group_config = jsonencode({ "CpuRateLimit" : 10, "MemoryLimit" : 10, "MemorySharedQuota" : 80, "MemorySpillRatio" : 0, "Concurrency" : 10 })
  db_instance_id        = alicloud_gpdb_instance.defaultJXWSlW.id
  resource_group_name   = "yb_example_group"
}
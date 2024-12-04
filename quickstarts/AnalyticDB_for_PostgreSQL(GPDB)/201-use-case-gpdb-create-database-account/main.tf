variable "name" {
  default = "terraform-example"
}

variable "region" {
  default = "cn-shenzhen"
}

variable "zone_id" {
  default = "cn-shenzhen-e"
}

variable "db_instance_class" {
  default = "gpdb.group.segsdx1"
}

variable "instance_spec" {
  default = "2C16G"
}

provider "alicloud" {
  region = var.region
}

resource "alicloud_vpc" "default" {
  vpc_name   = "alicloud"
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vpc_id     = alicloud_vpc.default.id
  cidr_block = "172.16.192.0/20"
  zone_id    = var.zone_id
}

resource "alicloud_gpdb_instance" "default" {
  db_instance_category  = "HighAvailability"
  db_instance_class     = var.db_instance_class
  db_instance_mode      = "StorageElastic"
  description           = var.name
  engine                = "gpdb"
  engine_version        = "6.0"
  zone_id               = var.zone_id
  instance_network_type = "VPC"
  instance_spec         = var.instance_spec
  payment_type          = "PayAsYouGo"
  seg_storage_type      = "cloud_essd"
  seg_node_num          = 4
  storage_size          = 50
  vpc_id                = alicloud_vpc.default.id
  vswitch_id            = alicloud_vswitch.default.id
  ip_whitelist {
    security_ip_list = "127.0.0.1"
  }
}

resource "alicloud_gpdb_account" "default" {
  account_name        = "tf_example"
  db_instance_id      = alicloud_gpdb_instance.default.id
  account_password    = "Example1234"
  account_description = "tf_example"
}
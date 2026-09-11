variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-shanghai"
}

variable "zone_id" {
  default = "cn-shanghai-b"
}

variable "cidr_block" {
  default = "10.0.0.0/24"
}

resource "alicloud_vpc" "default" {
  cidr_block = "10.0.0.0/8"
  vpc_name   = "bgg-vpc-shanghai-b"
}

resource "alicloud_vswitch" "default" {
  vpc_id     = alicloud_vpc.default.id
  zone_id    = var.zone_id
  cidr_block = var.cidr_block
}

resource "alicloud_mongodb_instance" "default" {
  engine_version      = "5.0"
  storage_type        = "cloud_essd1"
  vswitch_id          = alicloud_vswitch.default.id
  db_instance_storage = "20"
  vpc_id              = alicloud_vpc.default.id
  db_instance_class   = "mdb.shard.4x.large.d"
  storage_engine      = "WiredTiger"
  network_type        = "VPC"
  zone_id             = var.zone_id
  replication_factor  = "3"
  readonly_replicas   = "0"
}

resource "alicloud_mongodb_backup" "default" {
  backup_method           = "Snapshot"
  db_instance_id          = alicloud_mongodb_instance.default.id
  backup_retention_period = 7
}
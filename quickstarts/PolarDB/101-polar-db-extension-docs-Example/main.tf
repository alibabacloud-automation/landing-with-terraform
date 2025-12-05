variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

data "alicloud_polardb_node_classes" "default" {
  db_type  = "PostgreSQL"
  pay_type = "PostPaid"
  category = "Normal"
}

resource "alicloud_vpc" "default" {
  vpc_name   = "terraform-example"
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_polardb_node_classes.default.classes[0].zone_id
  vswitch_name = "terraform-example"
}

resource "alicloud_polardb_cluster" "dbcluster" {
  default_time_zone = "SYSTEM"
  creation_category = "Normal"
  zone_id           = data.alicloud_polardb_node_classes.default.classes[0].zone_id
  creation_option   = "Normal"
  db_version        = "14"
  pay_type          = "PostPaid"
  db_type           = "PostgreSQL"
  db_node_class     = "polar.pg.x4.medium.c"
  vswitch_id        = alicloud_vswitch.default.id
}

resource "alicloud_polardb_account" "account" {
  account_type     = "Normal"
  account_name     = "nzh"
  account_password = "Ali123456"
  db_cluster_id    = alicloud_polardb_cluster.dbcluster.id
}

resource "alicloud_polardb_database" "database" {
  character_set_name = "UTF8"
  db_description     = var.name
  db_cluster_id      = alicloud_polardb_cluster.dbcluster.id
  db_name            = "nzh"
  account_name       = alicloud_polardb_account.account.db_cluster_id
}


resource "alicloud_polar_db_extension" "default" {
  extension_name = "postgres_fdw"
  db_cluster_id  = alicloud_polardb_cluster.dbcluster.id
  account_name   = alicloud_polardb_account.account.account_name
  db_name        = alicloud_polardb_database.database.db_name
}
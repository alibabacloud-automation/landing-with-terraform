data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "main" {
  vpc_name   = "alicloud"
  cidr_block = "10.1.0.0/21"
}

resource "alicloud_vswitch" "main" {
  vpc_id     = alicloud_vpc.main.id
  cidr_block = "10.1.0.0/24"
  zone_id    = data.alicloud_zones.default.zones[0].id
}

resource "alicloud_db_instance" "instance" {
  engine           = "MySQL"
  engine_version   = "5.6"
  instance_type    = "rds.mysql.t1.small"
  instance_storage = "10"
  vswitch_id       = alicloud_vswitch.main.id
}

resource "alicloud_rds_account" "account" {
  db_instance_id   = alicloud_db_instance.instance.id
  account_name     = "tf_account"
  account_password = "!Test@123456"
}

resource "alicloud_db_database" "db" {
  instance_id = alicloud_db_instance.instance.id
  name        = "tf_database"
}

resource "alicloud_db_account_privilege" "privilege" {
  instance_id  = alicloud_db_instance.instance.id
  account_name = alicloud_rds_account.account.account_name
  db_names     = [alicloud_db_database.db.name]
}

resource "alicloud_db_connection" "connection" {
  instance_id       = alicloud_db_instance.instance.id
  connection_prefix = "tf-example"
}
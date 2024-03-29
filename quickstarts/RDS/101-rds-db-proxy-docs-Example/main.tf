variable "name" {
  default = "tf-example"
}
data "alicloud_db_zones" "default" {
  engine         = "MySQL"
  engine_version = "5.6"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "172.16.0.0/16"
}
resource "alicloud_vswitch" "default" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_db_zones.default.zones.0.id
  vswitch_name = var.name
}

resource "alicloud_security_group" "default" {
  name   = var.name
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_db_instance" "default" {
  engine                   = "MySQL"
  engine_version           = "5.7"
  instance_type            = "rds.mysql.c1.large"
  instance_storage         = "20"
  instance_charge_type     = "Postpaid"
  instance_name            = var.name
  vswitch_id               = alicloud_vswitch.default.id
  db_instance_storage_type = "local_ssd"
}

resource "alicloud_db_readonly_instance" "default" {
  zone_id               = alicloud_db_instance.default.zone_id
  master_db_instance_id = alicloud_db_instance.default.id
  engine_version        = alicloud_db_instance.default.engine_version
  instance_storage      = alicloud_db_instance.default.instance_storage
  instance_type         = alicloud_db_instance.default.instance_type
  instance_name         = "${var.name}readonly"
  vswitch_id            = alicloud_vswitch.default.id
}

resource "alicloud_rds_db_proxy" "default" {
  instance_id                          = alicloud_db_instance.default.id
  instance_network_type                = "VPC"
  vpc_id                               = alicloud_db_instance.default.vpc_id
  vswitch_id                           = alicloud_db_instance.default.vswitch_id
  db_proxy_instance_num                = 2
  db_proxy_connection_prefix           = "example"
  db_proxy_connect_string_port         = 3306
  db_proxy_endpoint_read_write_mode    = "ReadWrite"
  read_only_instance_max_delay_time    = 90
  db_proxy_features                    = "TransactionReadSqlRouteOptimizeStatus:1;ConnectionPersist:1;ReadWriteSpliting:1"
  read_only_instance_distribution_type = "Custom"
  read_only_instance_weight {
    instance_id = alicloud_db_instance.default.id
    weight      = "100"
  }
  read_only_instance_weight {
    instance_id = alicloud_db_readonly_instance.default.id
    weight      = "500"
  }
}
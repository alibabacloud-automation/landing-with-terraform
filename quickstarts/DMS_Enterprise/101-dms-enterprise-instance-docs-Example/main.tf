variable "name" {
  default = "tf-example"
}

data "alicloud_account" "current" {}
data "alicloud_regions" "default" {
  current = true
}
data "alicloud_dms_user_tenants" "default" {
  status = "ACTIVE"
}

data "alicloud_db_zones" "default" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "HighAvailability"
  db_instance_storage_type = "cloud_essd"
}

data "alicloud_db_instance_classes" "default" {
  zone_id                  = data.alicloud_db_zones.default.zones.0.id
  engine                   = "MySQL"
  engine_version           = "8.0"
  category                 = "HighAvailability"
  db_instance_storage_type = "cloud_essd"
  instance_charge_type     = "PostPaid"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "10.4.0.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_db_zones.default.zones.0.id
}

resource "alicloud_security_group" "default" {
  name   = var.name
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_db_instance" "default" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  db_instance_storage_type = "cloud_essd"
  instance_type            = data.alicloud_db_instance_classes.default.instance_classes.0.instance_class
  instance_storage         = data.alicloud_db_instance_classes.default.instance_classes.0.storage_range.min
  vswitch_id               = alicloud_vswitch.default.id
  instance_name            = var.name
  security_ips             = ["100.104.5.0/24", "192.168.0.6"]
  tags = {
    Created = "TF",
    For     = "example",
  }
}

resource "alicloud_db_account" "default" {
  db_instance_id   = alicloud_db_instance.default.id
  account_name     = "tfexamplename"
  account_password = "Example12345"
  account_type     = "Normal"
}

resource "alicloud_dms_enterprise_instance" "default" {
  tid               = data.alicloud_dms_user_tenants.default.ids.0
  instance_type     = "mysql"
  instance_source   = "RDS"
  network_type      = "VPC"
  env_type          = "dev"
  host              = alicloud_db_instance.default.connection_string
  port              = 3306
  database_user     = alicloud_db_account.default.account_name
  database_password = alicloud_db_account.default.account_password
  instance_name     = var.name
  dba_uid           = data.alicloud_account.current.id
  # The value of safe_rule can be queried through the interface: https://www.alibabacloud.com/help/en/dms/developer-reference/api-dms-enterprise-2018-11-01-liststandardgroups
  safe_rule      = "904496"
  use_dsql       = 1
  query_timeout  = 60
  export_timeout = 600
  ecs_region     = data.alicloud_regions.default.regions.0.id
}
variable "name" {
  default = "tf-example"
}
data "alicloud_db_zones" "example" {
  engine         = "MySQL"
  engine_version = "5.6"
}

resource "alicloud_vpc" "example" {
  vpc_name   = var.name
  cidr_block = "172.16.0.0/16"
}
resource "alicloud_vswitch" "example" {
  vpc_id       = alicloud_vpc.example.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_db_zones.example.zones.0.id
  vswitch_name = var.name
}

resource "alicloud_security_group" "example" {
  name   = var.name
  vpc_id = alicloud_vpc.example.id
}

resource "alicloud_db_instance" "example" {
  engine               = "MySQL"
  engine_version       = "5.6"
  instance_type        = "rds.mysql.t1.small"
  instance_storage     = "20"
  instance_charge_type = "Postpaid"
  instance_name        = var.name
  vswitch_id           = alicloud_vswitch.example.id
  security_ips         = ["10.168.1.12", "100.69.7.112"]
}

resource "alicloud_db_readonly_instance" "example" {
  zone_id               = alicloud_db_instance.example.zone_id
  master_db_instance_id = alicloud_db_instance.example.id
  engine_version        = alicloud_db_instance.example.engine_version
  instance_storage      = alicloud_db_instance.example.instance_storage
  instance_type         = alicloud_db_instance.example.instance_type
  instance_name         = "${var.name}readonly"
  vswitch_id            = alicloud_vswitch.example.id
}
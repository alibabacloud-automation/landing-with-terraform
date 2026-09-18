data "alicloud_polardb_node_classes" "default" {
  db_type    = "PostgreSQL"
  db_version = "16"
  category   = "Normal"
  pay_type   = "PostPaid"
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

resource "alicloud_polardb_cluster" "default" {
  db_type       = "PostgreSQL"
  db_version    = "16"
  pay_type      = "PostPaid"
  cn_node_class = "polar.pg.x4.medium"
  dn_node_class = "polar.pg.x4.medium"
  cn_node_num   = 1
  dn_node_num   = 2
  vswitch_id    = alicloud_vswitch.default.id
  vpc_id        = alicloud_vpc.default.id
  description   = "terraform-example-distributed"
}
resource "alicloud_polardb_gateway" "default" {
  zone_id           = "cn-beijing-l"
  db_cluster_class  = "polar.app.g2.small"
  pay_type          = "Postpaid"
  vpc_id            = "vpc-xxx"
  vswitch_id        = "vsw-xxx"
  security_group_id = "sg-xxx"
  db_type           = "PostgreSQL"
}
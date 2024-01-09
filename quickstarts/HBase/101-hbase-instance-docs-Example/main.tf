variable "name" {
  default = "tf-example"
}
provider "alicloud" {
  region = "cn-hangzhou"
}
data "alicloud_hbase_zones" "default" {}
data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}
data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = data.alicloud_hbase_zones.default.zones[1].id
}

resource "alicloud_hbase_instance" "default" {
  name                   = var.name
  zone_id                = data.alicloud_hbase_zones.default.zones[1].id
  vswitch_id             = data.alicloud_vswitches.default.ids.0
  vpc_id                 = data.alicloud_vpcs.default.ids.0
  engine                 = "hbaseue"
  engine_version         = "2.0"
  master_instance_type   = "hbase.sn2.2xlarge"
  core_instance_type     = "hbase.sn2.2xlarge"
  core_instance_quantity = 2
  core_disk_type         = "cloud_efficiency"
  core_disk_size         = 400
  pay_type               = "PostPaid"
  cold_storage_size      = 0
  deletion_protection    = "false"
}
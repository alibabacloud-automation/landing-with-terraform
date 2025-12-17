variable "name" {
  default = "terraform-example"
}

data "alicloud_adb_zones" "default" {
}
data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}
resource "alicloud_vswitch" "default" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "10.4.0.0/24"
  zone_id      = data.alicloud_adb_zones.default.zones[0].id
  vswitch_name = var.name
}

resource "alicloud_adb_db_cluster" "default" {
  compute_resource    = "48Core192GB"
  db_cluster_category = "MixedStorage"
  db_cluster_version  = "3.0"
  db_node_class       = "E32"
  db_node_storage     = 100
  description         = var.name
  elastic_io_resource = 1
  maintain_time       = "04:00Z-05:00Z"
  mode                = "flexible"
  payment_type        = "PayAsYouGo"
  resource_group_id   = data.alicloud_resource_manager_resource_groups.default.ids.0
  security_ips        = ["10.168.1.12", "10.168.1.11"]
  vpc_id              = alicloud_vpc.default.id
  vswitch_id          = alicloud_vswitch.default.id
  zone_id             = data.alicloud_adb_zones.default.zones[0].id
  tags = {
    Created = "TF",
    For     = "example",
  }
}

resource "alicloud_adb_resource_group" "default" {
  group_name    = "TF_EXAMPLE"
  group_type    = "batch"
  node_num      = 0
  db_cluster_id = alicloud_adb_db_cluster.default.id
}
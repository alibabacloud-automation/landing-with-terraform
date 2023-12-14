variable "name" {
  default = "tf-example"
}
data "alicloud_click_house_regions" "default" {
  current = true
}
resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "10.4.0.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_click_house_regions.default.regions.0.zone_ids.0.zone_id
}

resource "alicloud_click_house_db_cluster" "default" {
  db_cluster_version      = "22.8.5.29"
  status                  = "Running"
  category                = "Basic"
  db_cluster_class        = "S8"
  db_cluster_network_type = "vpc"
  db_node_group_count     = "1"
  payment_type            = "PayAsYouGo"
  db_node_storage         = "500"
  storage_type            = "cloud_essd"
  vswitch_id              = alicloud_vswitch.default.id
  vpc_id                  = alicloud_vpc.default.id
}

resource "alicloud_click_house_backup_policy" "default" {
  db_cluster_id           = alicloud_click_house_db_cluster.default.id
  preferred_backup_period = ["Monday", "Friday"]
  preferred_backup_time   = "00:00Z-01:00Z"
  backup_retention_period = 7
}
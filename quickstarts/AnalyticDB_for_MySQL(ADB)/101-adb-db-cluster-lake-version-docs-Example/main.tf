provider "alicloud" {
  region = "ap-southeast-1"
}

data "alicloud_adb_zones" "default" {
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}

data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = data.alicloud_adb_zones.default.ids.0
}

resource "alicloud_adb_db_cluster_lake_version" "default" {
  db_cluster_version            = "5.0"
  vpc_id                        = data.alicloud_vpcs.default.ids.0
  vswitch_id                    = data.alicloud_vswitches.default.ids.0
  zone_id                       = data.alicloud_adb_zones.default.ids.0
  compute_resource              = "16ACU"
  storage_resource              = "0ACU"
  payment_type                  = "PayAsYouGo"
  enable_default_resource_group = false
}
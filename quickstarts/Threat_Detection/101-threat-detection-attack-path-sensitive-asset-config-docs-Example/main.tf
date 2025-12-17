provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_slb_load_balancers" "default" {
}

resource "alicloud_threat_detection_attack_path_sensitive_asset_config" "default" {
  attack_path_asset_list {
    instance_id    = data.alicloud_slb_load_balancers.default.balancers.0.id
    vendor         = "0"
    asset_type     = "1"
    asset_sub_type = "0"
    region_id      = "cn-hangzhou"
  }
}
variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_threat_detection_assets" "default" {
  machine_types = "ecs"
}

resource "alicloud_threat_detection_asset_bind" "default" {
  uuid         = data.alicloud_threat_detection_assets.default.assets.0.uuid
  auth_version = "5"
}
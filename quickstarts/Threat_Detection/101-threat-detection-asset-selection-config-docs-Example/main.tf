variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}


resource "alicloud_threat_detection_asset_selection_config" "default" {
  business_type = "agentlesss_vul_white_1"
  target_type   = "instance"
  platform      = "all"
}
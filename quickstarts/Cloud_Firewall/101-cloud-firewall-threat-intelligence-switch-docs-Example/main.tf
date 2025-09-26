variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_cloud_firewall_threat_intelligence_switch" "default" {
  action        = "alert"
  enable_status = "0"
  category_id   = "IpOutThreatTorExit"
}
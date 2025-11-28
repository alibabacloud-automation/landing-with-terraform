variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_cloud_firewall_ai_traffic_analysis_status" "default" {
  status = "Open"
}
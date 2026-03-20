variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}


resource "alicloud_nlb_hd_monitor_region_config" "default" {
  metric_store = "example"
  log_project  = "example"
}
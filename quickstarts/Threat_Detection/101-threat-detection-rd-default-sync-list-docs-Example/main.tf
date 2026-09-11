variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_threat_detection_rd_default_sync_list" "default" {
  folder_ids = ["fd-xxxxx", "fd-yyyyy"]
}
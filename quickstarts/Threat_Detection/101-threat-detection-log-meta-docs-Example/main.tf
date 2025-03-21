variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-shanghai"
}


resource "alicloud_threat_detection_log_meta" "default" {
  status        = "disabled"
  log_meta_name = "aegis-log-client"
}
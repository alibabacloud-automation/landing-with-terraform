provider "alicloud" {
  region = "cn-shanghai"
}

variable "name" {
  default = "tf_example"
}

resource "alicloud_sag_qos" "default" {
  name = var.name
}

resource "alicloud_sag_qos_car" "default" {
  qos_id              = alicloud_sag_qos.default.id
  name                = var.name
  description         = var.name
  priority            = "1"
  limit_type          = "Absolute"
  min_bandwidth_abs   = "10"
  max_bandwidth_abs   = "20"
  percent_source_type = "InternetUpBandwidth"
}
provider "alicloud" {
  region = var.region
}

variable "region" {
  default = "cn-hangzhou"
}
variable "name" {
  default = "tfexample"
}

resource "alicloud_edas_namespace" "default" {
  debug_enable         = false
  description          = var.name
  namespace_logical_id = "${var.region}:${var.name}"
  namespace_name       = var.name
}
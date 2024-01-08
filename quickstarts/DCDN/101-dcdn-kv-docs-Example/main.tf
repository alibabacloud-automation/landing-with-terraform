variable "name" {
  default = "terraform-example"
}

resource "alicloud_dcdn_kv_namespace" "default" {
  description = var.name
  namespace   = var.name
}

resource "alicloud_dcdn_kv" "default" {
  value     = "example-value"
  key       = var.name
  namespace = alicloud_dcdn_kv_namespace.default.namespace
}
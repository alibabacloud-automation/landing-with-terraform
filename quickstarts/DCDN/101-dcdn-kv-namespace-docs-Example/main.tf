variable "name" {
  default = "terraform-example"
}
resource "alicloud_dcdn_kv_namespace" "default" {
  description = var.name
  namespace   = var.name
}
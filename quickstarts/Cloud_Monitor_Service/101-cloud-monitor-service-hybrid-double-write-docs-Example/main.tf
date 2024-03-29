variable "name" {
  default = "tf-example"
}

data "alicloud_account" "default" {
}

resource "alicloud_cms_namespace" "source" {
  namespace = var.name
}

resource "alicloud_cms_namespace" "default" {
  namespace = "${var.name}-source"
}

resource "alicloud_cloud_monitor_service_hybrid_double_write" "default" {
  source_namespace = alicloud_cms_namespace.source.id
  source_user_id   = data.alicloud_account.default.id
  namespace        = alicloud_cms_namespace.default.id
  user_id          = data.alicloud_account.default.id
}
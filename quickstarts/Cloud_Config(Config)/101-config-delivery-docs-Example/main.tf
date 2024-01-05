variable "name" {
  default = "tf-example-sls"
}
data "alicloud_account" "this" {}
data "alicloud_regions" "this" {
  current = true
}

resource "alicloud_log_project" "default" {
  name = var.name
}
resource "alicloud_log_store" "default" {
  name    = var.name
  project = alicloud_log_project.default.name
}

resource "alicloud_config_delivery" "default" {
  configuration_item_change_notification = true
  non_compliant_notification             = true
  delivery_channel_name                  = var.name
  delivery_channel_target_arn            = "acs:log:${data.alicloud_regions.this.ids.0}:${data.alicloud_account.this.id}:project/${alicloud_log_project.default.name}/logstore/${alicloud_log_store.default.name}"
  delivery_channel_type                  = "SLS"
  description                            = var.name
}
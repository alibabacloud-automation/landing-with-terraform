variable "name" {
  default = "tf_example"
}
data "alicloud_regions" "this" {
  current = true
}
data "alicloud_account" "this" {}
data "alicloud_resource_manager_accounts" "default" {
  status = "CreateSuccess"
}
locals {
  last = length(data.alicloud_resource_manager_accounts.default.accounts) - 1
}

resource "alicloud_config_aggregator" "default" {
  aggregator_accounts {
    account_id   = data.alicloud_resource_manager_accounts.default.accounts[local.last].account_id
    account_name = data.alicloud_resource_manager_accounts.default.accounts[local.last].display_name
    account_type = "ResourceDirectory"
  }
  aggregator_name = var.name
  description     = var.name
  aggregator_type = "CUSTOM"
}

resource "random_uuid" "default" {}
resource "alicloud_log_project" "default" {
  project_name = substr("tf-example-${replace(random_uuid.default.result, "-", "")}", 0, 16)
}
resource "alicloud_log_store" "default" {
  logstore_name = var.name
  project_name  = alicloud_log_project.default.project_name
}
resource "alicloud_config_aggregate_delivery" "default" {
  aggregator_id                          = alicloud_config_aggregator.default.id
  configuration_item_change_notification = true
  non_compliant_notification             = true
  delivery_channel_name                  = var.name
  delivery_channel_target_arn            = "acs:log:${data.alicloud_regions.this.ids.0}:${data.alicloud_account.this.id}:project/${alicloud_log_project.default.project_name}/logstore/${alicloud_log_store.default.logstore_name}"
  delivery_channel_type                  = "SLS"
  description                            = var.name
}
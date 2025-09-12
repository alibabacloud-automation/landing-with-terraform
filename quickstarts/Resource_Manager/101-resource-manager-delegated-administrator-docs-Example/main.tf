data "alicloud_resource_manager_accounts" "default" {
  status = "CreateSuccess"
}

resource "alicloud_resource_manager_delegated_administrator" "default" {
  account_id        = data.alicloud_resource_manager_accounts.default.accounts.0.account_id
  service_principal = "cloudfw.aliyuncs.com"
}
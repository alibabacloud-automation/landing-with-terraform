variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-shanghai"
}

data "alicloud_resource_manager_accounts" "default" {
  status = "CreateSuccess"
}
resource "alicloud_resource_manager_delegated_administrator" "default" {
  account_id        = data.alicloud_resource_manager_accounts.default.accounts.0.account_id
  service_principal = "cloudsso.aliyuncs.com"
}

resource "alicloud_cloud_sso_delegate_account" "default" {
  account_id = alicloud_resource_manager_delegated_administrator.default.account_id
}
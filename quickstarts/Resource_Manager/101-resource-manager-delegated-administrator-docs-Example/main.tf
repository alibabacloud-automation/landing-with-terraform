variable "name" {
  default = "tf-example"
}
variable "display_name" {
  default = "EAccount"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

data "alicloud_resource_manager_folders" "example" {

}

resource "alicloud_resource_manager_account" "example" {
  display_name = "${var.display_name}-${random_integer.default.result}"
  folder_id    = data.alicloud_resource_manager_folders.example.ids.0
}

resource "alicloud_resource_manager_delegated_administrator" "example" {
  account_id        = alicloud_resource_manager_account.example.id
  service_principal = "cloudfw.aliyuncs.com"
}
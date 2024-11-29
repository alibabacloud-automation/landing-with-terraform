variable "region" {
  default = "cn-hangzhou"
}
provider "alicloud" {
  region = var.region
}
resource "random_integer" "default" {
  min = 10000
  max = 99999
}
# 创建云备份库
resource "alicloud_hbr_vault" "example" {
  vault_name = "example_value_${random_integer.default.result}"
}
resource "random_integer" "default" {
  min = 10000
  max = 99999
}
resource "alicloud_resource_manager_account" "default" {
  display_name = "RDAccount_auto_${random_integer.default.result}"
}
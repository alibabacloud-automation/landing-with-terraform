resource "random_integer" "default" {
  min = 10000
  max = 99999
}
resource "alicloud_hbr_vault" "example" {
  vault_name = "example_value_${random_integer.default.result}"
}
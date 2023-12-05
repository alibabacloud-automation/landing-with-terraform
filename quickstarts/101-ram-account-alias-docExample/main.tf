variable "name" {
  default = "tfexample"
}
resource "alicloud_ram_account_alias" "alias" {
  account_alias = var.name
}
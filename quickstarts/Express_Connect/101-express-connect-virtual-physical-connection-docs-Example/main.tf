provider "alicloud" {
  region = "cn-hangzhou"
}
variable "name" {
  default = "tf-example"
}
data "alicloud_express_connect_physical_connections" "example" {
  name_regex = "^preserved-NODELETING"
}
resource "random_integer" "vlan_id" {
  max = 2999
  min = 1
}
data "alicloud_account" "default" {}
resource "alicloud_express_connect_virtual_physical_connection" "example" {
  virtual_physical_connection_name = var.name
  description                      = var.name
  order_mode                       = "PayByPhysicalConnectionOwner"
  parent_physical_connection_id    = data.alicloud_express_connect_physical_connections.example.ids.0
  spec                             = "50M"
  vlan_id                          = random_integer.vlan_id.id
  vpconn_ali_uid                   = data.alicloud_account.default.id
}
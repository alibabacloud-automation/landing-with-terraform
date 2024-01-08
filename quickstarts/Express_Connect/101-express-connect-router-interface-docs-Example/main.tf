variable "name" {
  default = "tf_example"
}
resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "172.16.0.0/12"
}
data "alicloud_regions" "default" {
  current = true
}
resource "alicloud_express_connect_router_interface" "default" {
  description           = var.name
  opposite_region_id    = data.alicloud_regions.default.regions.0.id
  router_id             = alicloud_vpc.default.router_id
  role                  = "InitiatingSide"
  router_type           = "VRouter"
  payment_type          = "PayAsYouGo"
  router_interface_name = var.name
  spec                  = "Mini.2"
}
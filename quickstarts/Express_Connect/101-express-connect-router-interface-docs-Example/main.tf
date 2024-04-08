variable "name" {
  default = "tf_example"
}
data "alicloud_vpcs" "default" {
  name_regex = "default-NODELETING"
}
data "alicloud_regions" "default" {
  current = true
}
resource "alicloud_express_connect_router_interface" "default" {
  description           = var.name
  opposite_region_id    = data.alicloud_regions.default.regions.0.id
  router_id             = data.alicloud_vpcs.default.vpcs.0.router_id
  role                  = "InitiatingSide"
  router_type           = "VRouter"
  payment_type          = "PayAsYouGo"
  router_interface_name = var.name
  spec                  = "Mini.2"
}
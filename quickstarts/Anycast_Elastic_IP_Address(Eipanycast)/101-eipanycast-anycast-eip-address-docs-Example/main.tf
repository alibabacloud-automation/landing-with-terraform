variable "name" {
  default = "tf-example"
}

resource "alicloud_eipanycast_anycast_eip_address" "default" {
  anycast_eip_address_name = var.name
  description              = var.name
  bandwidth                = 200
  service_location         = "international"
  internet_charge_type     = "PayByTraffic"
  payment_type             = "PayAsYouGo"
}
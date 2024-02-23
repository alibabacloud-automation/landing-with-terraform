variable "name" {
  default = "tf-example"
}
resource "alicloud_eip_address" "default" {
  address_name         = var.name
  isp                  = "BGP"
  internet_charge_type = "PayByBandwidth"
  payment_type         = "PayAsYouGo"
}

resource "alicloud_ddos_basic_defense_threshold" "default" {
  instance_id   = alicloud_eip_address.default.id
  ddos_type     = "defense"
  instance_type = "eip"
  bps           = 390
  pps           = 90000
}
variable "name" {
  default = "terraform-example"
}

resource "alicloud_common_bandwidth_package" "default" {
  bandwidth            = 3
  internet_charge_type = "PayByBandwidth"
}

resource "alicloud_eip_address" "default" {
  bandwidth            = "3"
  internet_charge_type = "PayByTraffic"
}

resource "alicloud_common_bandwidth_package_attachment" "default" {
  bandwidth_package_id        = alicloud_common_bandwidth_package.default.id
  instance_id                 = alicloud_eip_address.default.id
  bandwidth_package_bandwidth = "2"
  ip_type                     = "EIP"
}
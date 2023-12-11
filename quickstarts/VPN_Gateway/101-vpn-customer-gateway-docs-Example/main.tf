resource "alicloud_vpn_customer_gateway" "foo" {
  name        = "vpnCgwNameExample"
  ip_address  = "43.104.22.228"
  description = "vpnCgwDescriptionExample"
}

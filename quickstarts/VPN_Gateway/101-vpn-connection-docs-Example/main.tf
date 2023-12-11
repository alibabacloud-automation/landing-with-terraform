variable "name" {
  default = "tf-example"
}
provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}
data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = data.alicloud_zones.default.ids.0
}

resource "alicloud_vpn_gateway" "foo" {
  name                 = var.name
  vpc_id               = data.alicloud_vpcs.default.ids.0
  bandwidth            = "10"
  enable_ssl           = true
  instance_charge_type = "PrePaid"
  description          = "test_create_description"
  vswitch_id           = data.alicloud_vswitches.default.ids.0
}

resource "alicloud_vpn_customer_gateway" "foo" {
  name        = var.name
  ip_address  = "42.104.22.210"
  description = var.name
}

resource "alicloud_vpn_connection" "foo" {
  name                = var.name
  vpn_gateway_id      = alicloud_vpn_gateway.foo.id
  customer_gateway_id = alicloud_vpn_customer_gateway.foo.id
  local_subnet        = ["172.16.0.0/24", "172.16.1.0/24"]
  remote_subnet       = ["10.0.0.0/24", "10.0.1.0/24"]
  effect_immediately  = true
  ike_config {
    ike_auth_alg  = "md5"
    ike_enc_alg   = "des"
    ike_version   = "ikev2"
    ike_mode      = "main"
    ike_lifetime  = 86400
    psk           = "tf-testvpn2"
    ike_pfs       = "group1"
    ike_remote_id = "testbob2"
    ike_local_id  = "testalice2"
  }
  ipsec_config {
    ipsec_pfs      = "group5"
    ipsec_enc_alg  = "des"
    ipsec_auth_alg = "md5"
    ipsec_lifetime = 8640
  }
}

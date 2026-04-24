variable "name" {
  default = "tf_example"
}

resource "alicloud_cen_instance" "example" {
  cen_instance_name = var.name
}

resource "alicloud_cen_transit_router" "example" {
  cen_id                     = alicloud_cen_instance.example.id
  transit_router_description = var.name
  transit_router_name        = var.name
}

resource "alicloud_vpn_customer_gateway" "example" {
  customer_gateway_name = var.name
  ip_address            = "42.104.22.210"
  asn                   = "45014"
  description           = var.name
}

resource "alicloud_vpn_gateway_vpn_attachment" "example" {
  network_type       = "public"
  local_subnet       = "0.0.0.0/0"
  remote_subnet      = "0.0.0.0/0"
  effect_immediately = false
  tunnel_options_specification {
    customer_gateway_id  = alicloud_vpn_customer_gateway.example.id
    role                 = "master"
    tunnel_index         = 1
    enable_dpd           = true
    enable_nat_traversal = true
    tunnel_ike_config {
      ike_auth_alg = "md5"
      ike_enc_alg  = "des"
      ike_version  = "ikev2"
      ike_mode     = "main"
      ike_lifetime = 86400
      psk          = "tf-examplevpn1"
      ike_pfs      = "group1"
      remote_id    = "examplebob1"
      local_id     = "examplealice1"
    }
    tunnel_ipsec_config {
      ipsec_pfs      = "group5"
      ipsec_enc_alg  = "des"
      ipsec_auth_alg = "md5"
      ipsec_lifetime = 86400
    }
  }
  tunnel_options_specification {
    customer_gateway_id  = alicloud_vpn_customer_gateway.example.id
    role                 = "slave"
    tunnel_index         = 2
    enable_dpd           = true
    enable_nat_traversal = true
    tunnel_ike_config {
      ike_auth_alg = "md5"
      ike_enc_alg  = "des"
      ike_version  = "ikev2"
      ike_mode     = "main"
      ike_lifetime = 86400
      psk          = "tf-examplevpn2"
      ike_pfs      = "group1"
      remote_id    = "examplebob2"
      local_id     = "examplealice2"
    }
    tunnel_ipsec_config {
      ipsec_pfs      = "group5"
      ipsec_enc_alg  = "des"
      ipsec_auth_alg = "md5"
      ipsec_lifetime = 86400
    }
  }
  vpn_attachment_name = var.name
}

resource "alicloud_cen_transit_router_cidr" "example" {
  transit_router_id        = alicloud_cen_transit_router.example.transit_router_id
  cidr                     = "192.168.0.0/16"
  transit_router_cidr_name = var.name
  description              = var.name
  publish_cidr_route       = true
}

resource "alicloud_cen_transit_router_vpn_attachment" "example" {
  auto_publish_route_enabled            = false
  transit_router_attachment_description = var.name
  transit_router_vpn_attachment_name    = var.name
  cen_id                                = alicloud_cen_transit_router.example.cen_id
  transit_router_id                     = alicloud_cen_transit_router_cidr.example.transit_router_id
  vpn_id                                = alicloud_vpn_gateway_vpn_attachment.example.id
}
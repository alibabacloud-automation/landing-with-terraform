variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_express_connect_physical_connections" "nameRegex" {
  name_regex = "^preserved-NODELETING"
}

resource "alicloud_express_connect_virtual_border_router" "defaultydbbk3" {
  physical_connection_id = data.alicloud_express_connect_physical_connections.nameRegex.connections.0.id
  vlan_id                = "1000"
  peer_gateway_ip        = "192.168.254.2"
  peering_subnet_mask    = "255.255.255.0"
  local_gateway_ip       = "192.168.254.1"
}

resource "alicloud_express_connect_router_express_connect_router" "defaultAAlhUy" {
  alibaba_side_asn = "65532"
}

data "alicloud_account" "current" {
}

resource "alicloud_express_connect_router_vbr_child_instance" "default" {
  child_instance_id        = alicloud_express_connect_virtual_border_router.defaultydbbk3.id
  child_instance_region_id = "cn-hangzhou"
  ecr_id                   = alicloud_express_connect_router_express_connect_router.defaultAAlhUy.id
  child_instance_type      = "VBR"
  child_instance_owner_id  = data.alicloud_account.current.id
}
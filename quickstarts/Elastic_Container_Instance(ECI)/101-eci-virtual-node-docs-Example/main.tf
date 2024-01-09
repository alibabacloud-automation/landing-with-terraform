variable "name" {
  default = "tf-example"
}

data "alicloud_eci_zones" "default" {}
resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.0.0.0/8"
}
resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "10.1.0.0/16"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_eci_zones.default.zones.0.zone_ids.0
}

resource "alicloud_security_group" "default" {
  name   = var.name
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_eip_address" "default" {
  isp                       = "BGP"
  address_name              = var.name
  netmode                   = "public"
  bandwidth                 = "1"
  security_protection_types = ["AntiDDoS_Enhanced"]
  payment_type              = "PayAsYouGo"
}
data "alicloud_resource_manager_resource_groups" "default" {}

resource "alicloud_eci_virtual_node" "default" {
  security_group_id     = alicloud_security_group.default.id
  virtual_node_name     = var.name
  vswitch_id            = alicloud_vswitch.default.id
  enable_public_network = false
  eip_instance_id       = alicloud_eip_address.default.id
  resource_group_id     = data.alicloud_resource_manager_resource_groups.default.groups.0.id
  kube_config           = "kube_config"
  tags = {
    Created = "TF"
  }
  taints {
    effect = "NoSchedule"
    key    = "TF"
    value  = "example"
  }
}
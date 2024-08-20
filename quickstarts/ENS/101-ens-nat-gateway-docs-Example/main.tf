variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "ens_region_id" {
  default = "cn-chenzhou-telecom_unicom_cmcc"
}

resource "alicloud_ens_network" "defaultObbrL7" {
  network_name  = var.name
  description   = var.name
  cidr_block    = "10.0.0.0/8"
  ens_region_id = var.ens_region_id
}

resource "alicloud_ens_vswitch" "defaulteFw783" {
  cidr_block    = "10.0.8.0/24"
  vswitch_name  = var.name
  ens_region_id = alicloud_ens_network.defaultObbrL7.ens_region_id
  network_id    = alicloud_ens_network.defaultObbrL7.id
}

resource "alicloud_ens_nat_gateway" "default" {
  vswitch_id    = alicloud_ens_vswitch.defaulteFw783.id
  ens_region_id = alicloud_ens_vswitch.defaulteFw783.ens_region_id
  network_id    = alicloud_ens_vswitch.defaulteFw783.network_id
  instance_type = "enat.default"
  nat_name      = var.name
}
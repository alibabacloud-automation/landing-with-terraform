variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "ens_region_id" {
  default = "cn-hangzhou-31"
}

resource "alicloud_ens_network" "default" {
  network_name  = var.name
  description   = var.name
  cidr_block    = "10.0.0.0/8"
  ens_region_id = var.ens_region_id
}

resource "alicloud_ens_network_route_table" "default" {
  network_id       = alicloud_ens_network.default.id
  associate_type   = "Gateway"
  route_table_name = var.name
  description      = var.name
}
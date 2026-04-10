variable "name" {
  default = "terraform-example"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vpc_ipv4_gateway" "default" {
  ipv4_gateway_name = var.name
  vpc_id            = alicloud_vpc.default.id
  enabled           = true
}

resource "alicloud_route_entry" "default" {
  route_table_id        = alicloud_vpc.default.route_table_id
  destination_cidrblock = "172.11.1.1/32"
  nexthop_type          = "Ipv4Gateway"
  nexthop_id            = alicloud_vpc_ipv4_gateway.default.id
}
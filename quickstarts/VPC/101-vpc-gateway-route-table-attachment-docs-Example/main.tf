resource "alicloud_vpc" "example" {
  cidr_block = "172.16.0.0/12"
  vpc_name   = "terraform-example"
}

resource "alicloud_route_table" "example" {
  vpc_id           = alicloud_vpc.example.id
  route_table_name = "terraform-example"
  description      = "terraform-example"
  associate_type   = "Gateway"
}

resource "alicloud_vpc_ipv4_gateway" "example" {
  ipv4_gateway_name = "terraform-example"
  vpc_id            = alicloud_vpc.example.id
  enabled           = "true"
}

resource "alicloud_vpc_gateway_route_table_attachment" "example" {
  ipv4_gateway_id = alicloud_vpc_ipv4_gateway.example.id
  route_table_id  = alicloud_route_table.example.id
}
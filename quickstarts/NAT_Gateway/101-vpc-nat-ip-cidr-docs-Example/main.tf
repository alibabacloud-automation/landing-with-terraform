data "alicloud_zones" "example" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "example" {
  vpc_name   = "terraform-example"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "example" {
  vpc_id       = alicloud_vpc.example.id
  cidr_block   = "172.16.0.0/21"
  zone_id      = data.alicloud_zones.example.zones.0.id
  vswitch_name = "terraform-example"
}

resource "alicloud_nat_gateway" "example" {
  vpc_id               = alicloud_vpc.example.id
  internet_charge_type = "PayByLcu"
  nat_gateway_name     = "terraform-example"
  description          = "terraform-example"
  nat_type             = "Enhanced"
  vswitch_id           = alicloud_vswitch.example.id
  network_type         = "intranet"
}

resource "alicloud_vpc_nat_ip_cidr" "example" {
  nat_gateway_id   = alicloud_nat_gateway.example.id
  nat_ip_cidr_name = "terraform-example"
  nat_ip_cidr      = "192.168.0.0/16"
}
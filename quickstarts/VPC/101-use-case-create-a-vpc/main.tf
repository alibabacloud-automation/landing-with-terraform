provider "alicloud" {
  configuration_source = "terraform-provider-alicloud/examples/vpc"
  region               = "cn-hangzhou"
}

resource "alicloud_vpc" "main" {
  # VPC name
  name = "alicloud"
  # CIDR block of the VPC
  cidr_block = "10.1.0.0/21"
}

resource "alicloud_vswitch" "main" {
  # VPC ID
  vpc_id = alicloud_vpc.main.id
  # CIDR block of the VSwitch
  cidr_block = "10.1.0.0/24"
  # Zone
  availability_zone = "cn-hangzhou-b"
  # Dependent resource (this dependent resource will be created first)
  depends_on = [alicloud_vpc.main]
}

variable "name" {
  default = "natGatewayExampleName"
}

resource "alicloud_vpc" "enhanced" {
  vpc_name   = var.name
  cidr_block = "10.0.0.0/8"
}

data "alicloud_enhanced_nat_available_zones" "enhanced" {}

resource "alicloud_vswitch" "enhanced" {
  vswitch_name = var.name
  zone_id      = data.alicloud_enhanced_nat_available_zones.enhanced.zones.0.zone_id
  cidr_block   = "10.10.0.0/20"
  vpc_id       = alicloud_vpc.enhanced.id
}

resource "alicloud_nat_gateway" "main" {
  vpc_id           = alicloud_vpc.enhanced.id
  nat_gateway_name = var.name
  payment_type     = "PayAsYouGo"
  vswitch_id       = alicloud_vswitch.enhanced.id
  nat_type         = "Enhanced"
}

resource "alicloud_eip_address" "foo" {
  address_name = var.name
}

resource "alicloud_eip_association" "foo" {
  allocation_id = alicloud_eip_address.foo.id
  instance_id   = alicloud_nat_gateway.main.id
}

# adding dnat entry
resource "alicloud_forward_entry" "default" {
  forward_table_id = alicloud_nat_gateway.main.forward_table_ids
  external_ip      = alicloud_eip_address.foo.ip_address
  external_port    = "80"
  ip_protocol      = "tcp"
  internal_ip      = "172.16.0.3"
  internal_port    = "8080"
}

# adding snat entry
resource "alicloud_snat_entry" "default" {
  depends_on        = [alicloud_eip_association.foo]
  snat_table_id     = alicloud_nat_gateway.main.snat_table_ids
  source_vswitch_id = alicloud_vswitch.enhanced.id
  snat_ip           = join(",", alicloud_eip_address.foo.*.ip_address)
}
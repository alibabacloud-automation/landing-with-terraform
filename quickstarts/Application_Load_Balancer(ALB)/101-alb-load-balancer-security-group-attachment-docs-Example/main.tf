variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "eu-central-1"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "create_vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = var.name
}

resource "alicloud_vswitch" "create_vsw_1" {
  vpc_id       = alicloud_vpc.create_vpc.id
  zone_id      = data.alicloud_zones.default.zones.0.id
  cidr_block   = "192.168.1.0/24"
  vswitch_name = var.name
}

resource "alicloud_vswitch" "create_vsw_2" {
  vpc_id       = alicloud_vpc.create_vpc.id
  zone_id      = data.alicloud_zones.default.zones.1.id
  cidr_block   = "192.168.2.0/24"
  vswitch_name = var.name
}

resource "alicloud_security_group" "create_security_group" {
  name   = var.name
  vpc_id = alicloud_vpc.create_vpc.id
}

resource "alicloud_alb_load_balancer" "create_alb" {
  load_balancer_name    = var.name
  load_balancer_edition = "Standard"
  vpc_id                = alicloud_vpc.create_vpc.id
  load_balancer_billing_config {
    pay_type = "PayAsYouGo"
  }
  address_type           = "Intranet"
  address_allocated_mode = "Fixed"
  zone_mappings {
    vswitch_id = alicloud_vswitch.create_vsw_2.id
    zone_id    = alicloud_vswitch.create_vsw_2.zone_id
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.create_vsw_1.id
    zone_id    = alicloud_vswitch.create_vsw_1.zone_id
  }
}

resource "alicloud_alb_load_balancer_security_group_attachment" "default" {
  security_group_id = alicloud_security_group.create_security_group.id
  load_balancer_id  = alicloud_alb_load_balancer.create_alb.id
}
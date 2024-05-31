variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "eu-central-1"
}

variable "direction" {
  default = "out"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "defaultDEiWfM" {
  cidr_block = "172.16.0.0/12"
  vpc_name   = var.name
}

resource "alicloud_vswitch" "defaultFHDM3F" {
  vpc_id     = alicloud_vpc.defaultDEiWfM.id
  zone_id    = data.alicloud_zones.default.zones.0.id
  cidr_block = "172.16.2.0/24"
}

resource "alicloud_nat_gateway" "defaultMbS2Ts" {
  vpc_id           = alicloud_vpc.defaultDEiWfM.id
  nat_gateway_name = var.name
  payment_type     = "PayAsYouGo"
  vswitch_id       = alicloud_vswitch.defaultFHDM3F.id
  nat_type         = "Enhanced"
}

resource "alicloud_cloud_firewall_address_book" "port" {
  description  = format("%s%s", var.name, "port")
  group_name   = format("%s%s", var.name, "port")
  group_type   = "port"
  address_list = ["22/22", "23/23", "24/24"]
}

resource "alicloud_cloud_firewall_address_book" "port-update" {
  description  = format("%s%s", var.name, "port-update")
  group_name   = format("%s%s", var.name, "port-update")
  group_type   = "port"
  address_list = ["22/22", "23/23", "24/24"]
}

resource "alicloud_cloud_firewall_address_book" "domain" {
  description  = format("%s%s", var.name, "domain")
  group_name   = format("%s%s", var.name, "domain")
  group_type   = "domain"
  address_list = ["alibaba.com", "aliyun.com", "alicloud.com"]
}

resource "alicloud_cloud_firewall_address_book" "ip" {
  description  = var.name
  group_name   = var.name
  group_type   = "ip"
  address_list = ["1.1.1.1/32", "2.2.2.2/32"]
}

resource "alicloud_cloud_firewall_nat_firewall_control_policy" "default" {
  application_name_list = [
    "ANY"
  ]
  description = var.name
  release     = "false"
  ip_version  = "4"
  repeat_days = [
    "1",
    "2",
    "3"
  ]
  repeat_start_time   = "21:00"
  acl_action          = "log"
  dest_port_group     = alicloud_cloud_firewall_address_book.port.group_name
  repeat_type         = "Weekly"
  nat_gateway_id      = alicloud_nat_gateway.defaultMbS2Ts.id
  source              = "1.1.1.1/32"
  direction           = "out"
  repeat_end_time     = "21:30"
  start_time          = "1699156800"
  destination         = "1.1.1.1/32"
  end_time            = "1888545600"
  source_type         = "net"
  proto               = "TCP"
  new_order           = "1"
  destination_type    = "net"
  dest_port_type      = "group"
  domain_resolve_type = "0"
}
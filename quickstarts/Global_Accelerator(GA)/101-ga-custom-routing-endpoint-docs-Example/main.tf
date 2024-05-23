variable "region" {
  default = "cn-hangzhou"
}

provider "alicloud" {
  region = var.region
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "default" {
  vpc_name   = "terraform-example"
  cidr_block = "172.17.3.0/24"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = "terraform-example"
  cidr_block   = "172.17.3.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_ga_accelerator" "default" {
  duration        = 1
  auto_use_coupon = true
  spec            = "1"
}

resource "alicloud_ga_bandwidth_package" "default" {
  bandwidth      = 100
  type           = "Basic"
  bandwidth_type = "Basic"
  payment_type   = "PayAsYouGo"
  billing_type   = "PayBy95"
  ratio          = 30
}

resource "alicloud_ga_bandwidth_package_attachment" "default" {
  accelerator_id       = alicloud_ga_accelerator.default.id
  bandwidth_package_id = alicloud_ga_bandwidth_package.default.id
}

resource "alicloud_ga_listener" "default" {
  accelerator_id = alicloud_ga_bandwidth_package_attachment.default.accelerator_id
  listener_type  = "CustomRouting"
  port_ranges {
    from_port = 10000
    to_port   = 16000
  }
}

resource "alicloud_ga_custom_routing_endpoint_group" "default" {
  accelerator_id                     = alicloud_ga_listener.default.accelerator_id
  listener_id                        = alicloud_ga_listener.default.id
  endpoint_group_region              = var.region
  custom_routing_endpoint_group_name = "terraform-example"
  description                        = "terraform-example"
}

resource "alicloud_ga_custom_routing_endpoint" "default" {
  endpoint_group_id          = alicloud_ga_custom_routing_endpoint_group.default.id
  endpoint                   = alicloud_vswitch.default.id
  type                       = "PrivateSubNet"
  traffic_to_endpoint_policy = "DenyAll"
}
variable "region" {
  default = "cn-shenzhen"
}

variable "endpoint_region" {
  default = "cn-hangzhou"
}

provider "alicloud" {
  region = var.region
  alias  = "sz"
}

provider "alicloud" {
  region = var.endpoint_region
  alias  = "hz"
}

data "alicloud_zones" "default" {
  provider                    = alicloud.sz
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "default" {
  provider   = alicloud.sz
  vpc_name   = "terraform-example"
  cidr_block = "172.17.3.0/24"
}

resource "alicloud_vswitch" "default" {
  provider     = alicloud.sz
  vswitch_name = "terraform-example"
  cidr_block   = "172.17.3.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "default" {
  provider = alicloud.sz
  vpc_id   = alicloud_vpc.default.id
  name     = "terraform-example"
}

resource "alicloud_ecs_network_interface" "default" {
  provider           = alicloud.sz
  vswitch_id         = alicloud_vswitch.default.id
  security_group_ids = [alicloud_security_group.default.id]
}

resource "alicloud_ga_basic_accelerator" "default" {
  duration               = 1
  basic_accelerator_name = "terraform-example"
  description            = "terraform-example"
  bandwidth_billing_type = "CDT"
  auto_use_coupon        = "true"
  auto_pay               = true
}

resource "alicloud_ga_basic_endpoint_group" "default" {
  accelerator_id            = alicloud_ga_basic_accelerator.default.id
  endpoint_group_region     = var.region
  basic_endpoint_group_name = "terraform-example"
  description               = "terraform-example"
}

resource "alicloud_ga_basic_endpoint" "default" {
  provider                  = alicloud.hz
  accelerator_id            = alicloud_ga_basic_accelerator.default.id
  endpoint_group_id         = alicloud_ga_basic_endpoint_group.default.id
  endpoint_type             = "ENI"
  endpoint_address          = alicloud_ecs_network_interface.default.id
  endpoint_sub_address_type = "secondary"
  endpoint_sub_address      = "192.168.0.1"
  basic_endpoint_name       = "terraform-example"
}
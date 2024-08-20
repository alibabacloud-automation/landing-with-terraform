variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_vpc" "vpc" {
  cidr_block = "172.16.0.0/12"
  vpc_name   = var.name
}

resource "alicloud_vswitch" "vswitch_1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "172.16.0.0/16"
  zone_id      = "cn-hangzhou-j"
  vswitch_name = "${var.name}_1"
}

resource "alicloud_vswitch" "vswitch_2" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "172.17.0.0/16"
  zone_id      = "cn-hangzhou-k"
  vswitch_name = "${var.name}_2"
}

resource "alicloud_security_group" "security_group" {
  vpc_id = alicloud_vpc.vpc.id
  name   = var.name
}

resource "alicloud_api_gateway_instance" "vpc_integration_instance" {
  instance_name = var.name
  https_policy  = "HTTPS2_TLS1_0"
  instance_spec = "api.s1.small"
  instance_type = "vpc_connect"
  payment_type  = "PayAsYouGo"
  user_vpc_id   = alicloud_vpc.vpc.id
  instance_cidr = "192.168.0.0/16"
  zone_vswitch_security_group {
    zone_id        = alicloud_vswitch.vswitch_1.zone_id
    vswitch_id     = alicloud_vswitch.vswitch_1.id
    cidr_block     = alicloud_vswitch.vswitch_1.cidr_block
    security_group = alicloud_security_group.security_group.id
  }
  zone_vswitch_security_group {
    zone_id        = alicloud_vswitch.vswitch_2.zone_id
    vswitch_id     = alicloud_vswitch.vswitch_2.id
    cidr_block     = alicloud_vswitch.vswitch_2.cidr_block
    security_group = alicloud_security_group.security_group.id
  }
}
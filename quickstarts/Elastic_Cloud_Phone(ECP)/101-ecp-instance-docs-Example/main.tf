variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_ecp_zones" "default" {
}

data "alicloud_ecp_instance_types" "default" {
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_vpc" "default" {
  vpc_name   = "${var.name}-${random_integer.default.result}"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = "${var.name}-${random_integer.default.result}"
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "192.168.192.0/24"
  zone_id      = data.alicloud_ecp_zones.default.zones.0.zone_id
}

resource "alicloud_security_group" "default" {
  name   = "${var.name}-${random_integer.default.result}"
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_ecp_key_pair" "default" {
  key_pair_name   = "${var.name}-${random_integer.default.result}"
  public_key_body = "ssh-rsa AAAAB3Nza12345678qwertyuudsfsg"
}

resource "alicloud_ecp_instance" "default" {
  instance_type     = data.alicloud_ecp_instance_types.default.instance_types.0.instance_type
  image_id          = "android-image-release5501072_a11_20240530.raw"
  vswitch_id        = alicloud_vswitch.default.id
  security_group_id = alicloud_security_group.default.id
  key_pair_name     = alicloud_ecp_key_pair.default.key_pair_name
  vnc_password      = "Ecp123"
  payment_type      = "PayAsYouGo"
  instance_name     = var.name
  description       = var.name
  force             = "true"
}
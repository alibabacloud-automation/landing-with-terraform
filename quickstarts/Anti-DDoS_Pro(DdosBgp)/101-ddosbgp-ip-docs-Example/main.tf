provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "terraform-example"
}

data "alicloud_account" "default" {
}

resource "alicloud_ddosbgp_instance" "default" {
  name             = var.name
  base_bandwidth   = 20
  bandwidth        = -1
  ip_count         = 100
  ip_type          = "IPv4"
  normal_bandwidth = 100
  type             = "Enterprise"
}

resource "alicloud_eip_address" "default" {
  address_name = var.name
}

resource "alicloud_ddosbgp_ip" "default" {
  instance_id = alicloud_ddosbgp_instance.default.id
  ip          = alicloud_eip_address.default.ip_address
  member_uid  = data.alicloud_account.default.id
}
provider "alicloud" {
  region = "cn-beijing"
}

variable "name" {
  default = "tf-example"
}
data "alicloud_resource_manager_resource_groups" "default" {}
resource "alicloud_ddosbgp_instance" "instance" {
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
  instance_id       = alicloud_ddosbgp_instance.instance.id
  ip                = alicloud_eip_address.default.ip_address
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.groups.0.id
}
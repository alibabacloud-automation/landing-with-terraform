provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tf-example"
}
data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}
resource "alicloud_vpc_public_ip_address_pool" "default" {
  description                 = var.name
  public_ip_address_pool_name = var.name
  isp                         = "BGP"
  resource_group_id           = data.alicloud_resource_manager_resource_groups.default.ids.0
}

resource "alicloud_vpc_public_ip_address_pool_cidr_block" "default" {
  public_ip_address_pool_id = alicloud_vpc_public_ip_address_pool.default.id
  cidr_block                = "47.118.126.0/25"
}
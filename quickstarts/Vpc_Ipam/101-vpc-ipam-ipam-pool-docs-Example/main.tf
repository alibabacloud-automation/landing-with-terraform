variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_vpc_ipam_ipam" "defaultIpam" {
  operating_region_list = ["cn-hangzhou"]
}

resource "alicloud_vpc_ipam_ipam_pool" "parentIpamPool" {
  ipam_scope_id  = alicloud_vpc_ipam_ipam.defaultIpam.private_default_scope_id
  ipam_pool_name = format("%s1", var.name)
  pool_region_id = alicloud_vpc_ipam_ipam.defaultIpam.region_id
}


resource "alicloud_vpc_ipam_ipam_pool" "default" {
  ipam_scope_id       = alicloud_vpc_ipam_ipam.defaultIpam.private_default_scope_id
  pool_region_id      = alicloud_vpc_ipam_ipam_pool.parentIpamPool.pool_region_id
  ipam_pool_name      = var.name
  source_ipam_pool_id = alicloud_vpc_ipam_ipam_pool.parentIpamPool.id
  ip_version          = "IPv4"
}
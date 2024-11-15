variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_vpc_ipam_ipam" "defaultIpam" {
  operating_region_list = ["cn-hangzhou"]
}

resource "alicloud_vpc_ipam_ipam_pool" "defaultIpamPool" {
  ipam_scope_id  = alicloud_vpc_ipam_ipam.defaultIpam.private_default_scope_id
  pool_region_id = alicloud_vpc_ipam_ipam.defaultIpam.region_id
  ip_version     = "IPv4"
}


resource "alicloud_vpc_ipam_ipam_pool_cidr" "default" {
  cidr         = "10.0.0.0/8"
  ipam_pool_id = alicloud_vpc_ipam_ipam_pool.defaultIpamPool.id
}
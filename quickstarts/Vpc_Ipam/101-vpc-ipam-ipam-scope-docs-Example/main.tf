variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_vpc_ipam_ipam" "defaultIpam" {
  operating_region_list = ["cn-hangzhou"]
  ipam_name             = var.name
}


resource "alicloud_vpc_ipam_ipam_scope" "default" {
  ipam_scope_name        = var.name
  ipam_id                = alicloud_vpc_ipam_ipam.defaultIpam.id
  ipam_scope_description = "This is a ipam scope."
  ipam_scope_type        = "private"
}
variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_resource_manager_resource_groups" "default" {}


resource "alicloud_vpc_ipam_ipam" "default" {
  ipam_description      = "This is my first Ipam."
  ipam_name             = var.name
  operating_region_list = ["cn-hangzhou"]
}
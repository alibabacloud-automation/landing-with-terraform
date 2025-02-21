variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_resource_manager_resource_groups" "default" {}


resource "alicloud_vpc_ipam_ipam_resource_discovery" "default" {
  operating_region_list               = ["cn-hangzhou"]
  ipam_resource_discovery_description = "This is a custom IPAM resource discovery."
  ipam_resource_discovery_name        = "example_resource_discovery"
}
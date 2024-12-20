variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_regions" "default" {
  current = true
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "172.17.3.0/24"
}

resource "alicloud_cen_instance" "default" {
  cen_instance_name = var.name
  description       = var.name
}

resource "alicloud_cen_instance_attachment" "default" {
  instance_id              = alicloud_cen_instance.default.id
  child_instance_id        = alicloud_vpc.default.id
  child_instance_type      = "VPC"
  child_instance_region_id = data.alicloud_regions.default.regions.0.id
}

resource "alicloud_cen_private_zone" "default" {
  cen_id           = alicloud_cen_instance_attachment.default.instance_id
  access_region_id = data.alicloud_regions.default.regions.0.id
  host_vpc_id      = alicloud_vpc.default.id
  host_region_id   = data.alicloud_regions.default.regions.0.id
}
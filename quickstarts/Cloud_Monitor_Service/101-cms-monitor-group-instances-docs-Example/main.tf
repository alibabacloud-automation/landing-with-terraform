variable "name" {
  default = "tf_example"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_cms_monitor_group" "default" {
  monitor_group_name = var.name
}
data "alicloud_regions" "default" {
  current = true
}
resource "alicloud_cms_monitor_group_instances" "example" {
  group_id = alicloud_cms_monitor_group.default.id
  instances {
    instance_id   = alicloud_vpc.default.id
    instance_name = var.name
    region_id     = data.alicloud_regions.default.regions.0.id
    category      = "vpc"
  }
}
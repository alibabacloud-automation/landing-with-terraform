variable "name" {
  default = "terraform-example"
}

data "alicloud_resource_manager_resource_groups" "default" {
}

resource "alicloud_eflo_vpd" "default" {
  cidr              = "10.0.0.0/8"
  vpd_name          = var.name
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.groups.0.id
}
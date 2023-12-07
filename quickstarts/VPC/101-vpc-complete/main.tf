data "alicloud_resource_manager_resource_groups" "default" {
  name_regex = "default"
}

resource "alicloud_vpc" "default" {
  dry_run     = var.dry_run
  enable_ipv6 = var.enable_ipv6
  user_cidrs = [
    "106.11.62.0/24"
  ]
  vpc_name    = var.vpc_name
  cidr_block  = var.cidr_block
  description = var.description
  tags = {
    For     = "Test"
    Created = "TF"
  }
  classic_link_enabled = var.classic_link_enabled
  ipv6_isp             = var.ipv6_isp
  resource_group_id    = data.alicloud_resource_manager_resource_groups.default.groups.0.id
}

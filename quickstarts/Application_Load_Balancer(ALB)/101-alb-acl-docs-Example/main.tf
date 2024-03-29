data "alicloud_resource_manager_resource_groups" "default" {}

resource "alicloud_alb_acl" "default" {
  acl_name          = "tf_example"
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.groups.0.id
}
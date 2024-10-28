provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_rds_service_linked_role" "default" {
  service_name = "AliyunServiceRoleForRdsPgsqlOnEcs"
}

data "alicloud_resource_manager_roles" "slr" {
}
resource "alicloud_rds_service_linked_role" "default" {
  service_name = "AliyunServiceRoleForRdsPgsqlOnEcs"
}
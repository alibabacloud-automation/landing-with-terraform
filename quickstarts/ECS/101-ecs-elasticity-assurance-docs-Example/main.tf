data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}
data "alicloud_zones" "default" {
  available_resource_creation = "Instance"
}
data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.c6"
}
resource "alicloud_ecs_elasticity_assurance" "default" {
  instance_amount                     = 1
  description                         = "before"
  zone_ids                            = [data.alicloud_zones.default.zones[2].id]
  private_pool_options_name           = "test_before"
  period                              = 1
  private_pool_options_match_criteria = "Open"
  instance_type                       = [data.alicloud_instance_types.default.instance_types.0.id]
  period_unit                         = "Month"
  assurance_times                     = "Unlimited"
  resource_group_id                   = data.alicloud_resource_manager_resource_groups.default.ids.0
}
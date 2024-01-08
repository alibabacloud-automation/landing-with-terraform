data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}
data "alicloud_regions" "default" {
  current = true
}
resource "alicloud_dts_instance" "default" {
  type                             = "sync"
  resource_group_id                = data.alicloud_resource_manager_resource_groups.default.ids.0
  payment_type                     = "Subscription"
  instance_class                   = "large"
  source_endpoint_engine_name      = "MySQL"
  source_region                    = data.alicloud_regions.default.regions.0.id
  destination_endpoint_engine_name = "MySQL"
  destination_region               = data.alicloud_regions.default.regions.0.id
}
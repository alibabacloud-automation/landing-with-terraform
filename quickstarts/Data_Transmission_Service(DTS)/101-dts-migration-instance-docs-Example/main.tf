data "alicloud_regions" "default" {
  current = true
}
resource "alicloud_dts_migration_instance" "default" {
  payment_type                     = "PayAsYouGo"
  source_endpoint_engine_name      = "MySQL"
  source_endpoint_region           = data.alicloud_regions.default.regions.0.id
  destination_endpoint_engine_name = "MySQL"
  destination_endpoint_region      = data.alicloud_regions.default.regions.0.id
  instance_class                   = "small"
  sync_architecture                = "oneway"
}
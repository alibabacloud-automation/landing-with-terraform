data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}
resource "alicloud_config_rule" "default" {
  description                = "If the resource matches one of the specified tag key-value pairs, the configuration is considered compliant."
  source_owner               = "ALIYUN"
  source_identifier          = "contains-tag"
  risk_level                 = 1
  tag_value_scope            = "example-value"
  tag_key_scope              = "example-key"
  exclude_resource_ids_scope = "example-resource_id"
  region_ids_scope           = "cn-hangzhou"
  config_rule_trigger_types  = "ConfigurationItemChangeNotification"
  resource_group_ids_scope   = data.alicloud_resource_manager_resource_groups.default.ids.0
  resource_types_scope = [
  "ACS::RDS::DBInstance"]
  rule_name = "contains-tag"
  input_parameters = {
    key   = "example"
    value = "example"
  }
}
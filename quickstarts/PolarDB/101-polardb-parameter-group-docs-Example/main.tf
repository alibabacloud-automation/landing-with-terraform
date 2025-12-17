resource "alicloud_polardb_parameter_group" "example" {
  parameter_group_name = "example_value"
  db_type              = "MySQL"
  db_version           = "8.0"
  parameters {
    param_name  = "wait_timeout"
    param_value = "86400"
  }
  description = "example_value"
}
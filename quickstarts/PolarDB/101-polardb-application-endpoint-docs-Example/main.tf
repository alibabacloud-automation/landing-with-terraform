# Assume you have already created a PolarDB Application
resource "alicloud_polardb_application_endpoint" "default" {
  application_id = "pa-xxx"
  endpoint_id    = "pa-xxx"
  net_type       = "Public"
}
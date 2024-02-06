provider "alicloud" {
  region = "cn-hangzhou"
}
resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_fc_service" "default" {
  name        = "example-value-${random_integer.default.result}"
  description = "example-value"
  publish     = "true"
}

resource "alicloud_fc_alias" "example" {
  alias_name      = "example-value"
  description     = "example-value"
  service_name    = alicloud_fc_service.default.name
  service_version = "1"
}
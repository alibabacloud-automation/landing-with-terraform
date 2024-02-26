variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_express_connect_physical_connections" "default" {
  name_regex = "preserved-NODELETING"
}

resource "alicloud_express_connect_ec_failover_test_job" "default" {
  description = var.name
  job_type    = "StartNow"
  resource_id = [
    "${data.alicloud_express_connect_physical_connections.default.ids.0}",
    "${data.alicloud_express_connect_physical_connections.default.ids.1}",
    "${data.alicloud_express_connect_physical_connections.default.ids.2}"
  ]
  job_duration              = "1"
  resource_type             = "PHYSICALCONNECTION"
  ec_failover_test_job_name = var.name
}
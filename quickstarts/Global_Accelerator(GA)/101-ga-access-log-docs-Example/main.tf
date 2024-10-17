variable "region" {
  default = "cn-hangzhou"
}

provider "alicloud" {
  region  = var.region
  profile = "default"
}

resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_log_project" "default" {
  name = "terraform-example-${random_integer.default.result}"
}

resource "alicloud_log_store" "default" {
  project = alicloud_log_project.default.name
  name    = "terraform-example"
}

resource "alicloud_ga_accelerator" "default" {
  duration        = 1
  auto_use_coupon = true
  spec            = "2"
}

resource "alicloud_ga_bandwidth_package" "default" {
  bandwidth      = 100
  type           = "Basic"
  bandwidth_type = "Basic"
  payment_type   = "PayAsYouGo"
  billing_type   = "PayBy95"
  ratio          = 30
}

resource "alicloud_ga_bandwidth_package_attachment" "default" {
  accelerator_id       = alicloud_ga_accelerator.default.id
  bandwidth_package_id = alicloud_ga_bandwidth_package.default.id
}

resource "alicloud_ga_listener" "default" {
  accelerator_id  = alicloud_ga_bandwidth_package_attachment.default.accelerator_id
  client_affinity = "SOURCE_IP"
  protocol        = "HTTP"
  name            = "terraform-example"

  port_ranges {
    from_port = 70
    to_port   = 70
  }
}

resource "alicloud_eip_address" "default" {
  bandwidth            = "10"
  internet_charge_type = "PayByBandwidth"
  address_name         = "terraform-example"
}

resource "alicloud_ga_endpoint_group" "default" {
  accelerator_id = alicloud_ga_listener.default.accelerator_id
  endpoint_configurations {
    endpoint = alicloud_eip_address.default.ip_address
    type     = "PublicIp"
    weight   = 20
  }
  endpoint_group_region = var.region
  listener_id           = alicloud_ga_listener.default.id
}

resource "alicloud_ga_access_log" "default" {
  accelerator_id     = alicloud_ga_accelerator.default.id
  listener_id        = alicloud_ga_listener.default.id
  endpoint_group_id  = alicloud_ga_endpoint_group.default.id
  sls_project_name   = alicloud_log_project.default.name
  sls_log_store_name = alicloud_log_store.default.name
  sls_region_id      = var.region
}
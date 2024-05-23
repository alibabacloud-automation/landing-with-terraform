variable "region" {
  default = "cn-hangzhou"
}

provider "alicloud" {
  region  = var.region
  profile = "default"
}

resource "alicloud_ga_accelerator" "default" {
  duration        = 1
  auto_use_coupon = true
  spec            = "1"
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
  accelerator_id = alicloud_ga_bandwidth_package_attachment.default.accelerator_id
  port_ranges {
    from_port = 60
    to_port   = 70
  }
  client_affinity = "SOURCE_IP"
  protocol        = "UDP"
  name            = "terraform-example"
}

resource "alicloud_eip_address" "default" {
  count                = 2
  bandwidth            = "10"
  internet_charge_type = "PayByBandwidth"
  address_name         = "terraform-example"
}

resource "alicloud_ga_endpoint_group" "default" {
  accelerator_id = alicloud_ga_accelerator.default.id
  endpoint_configurations {
    endpoint = alicloud_eip_address.default.0.ip_address
    type     = "PublicIp"
    weight   = "20"
  }
  endpoint_configurations {
    endpoint = alicloud_eip_address.default.1.ip_address
    type     = "PublicIp"
    weight   = "20"
  }
  endpoint_group_region = var.region
  listener_id           = alicloud_ga_listener.default.id
}
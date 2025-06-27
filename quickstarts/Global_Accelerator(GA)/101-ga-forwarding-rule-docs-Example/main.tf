provider "alicloud" {
  region = var.region
}

variable "region" {
  default = "cn-hangzhou"
}

variable "name" {
  default = "terraform-example"
}

data "alicloud_regions" "default" {
  current = true
}

resource "alicloud_ga_accelerator" "example" {
  duration            = 3
  spec                = "2"
  accelerator_name    = var.name
  auto_use_coupon     = false
  description         = var.name
  auto_renew_duration = "2"
  renewal_status      = "AutoRenewal"
}

resource "alicloud_ga_bandwidth_package" "example" {
  type                   = "Basic"
  bandwidth              = 20
  bandwidth_type         = "Basic"
  duration               = 1
  auto_pay               = true
  payment_type           = "Subscription"
  auto_use_coupon        = false
  bandwidth_package_name = var.name
  description            = var.name
}

resource "alicloud_ga_bandwidth_package_attachment" "example" {
  accelerator_id       = alicloud_ga_accelerator.example.id
  bandwidth_package_id = alicloud_ga_bandwidth_package.example.id
}

resource "alicloud_ga_listener" "example" {
  accelerator_id  = alicloud_ga_bandwidth_package_attachment.example.accelerator_id
  client_affinity = "SOURCE_IP"
  description     = var.name
  name            = var.name
  protocol        = "HTTP"
  proxy_protocol  = true
  port_ranges {
    from_port = 60
    to_port   = 60
  }
}

resource "alicloud_eip_address" "example" {
  bandwidth            = "10"
  internet_charge_type = "PayByBandwidth"
}

resource "alicloud_ga_endpoint_group" "virtual" {
  accelerator_id = alicloud_ga_accelerator.example.id
  endpoint_configurations {
    endpoint                     = alicloud_eip_address.example.ip_address
    type                         = "PublicIp"
    weight                       = "20"
    enable_clientip_preservation = true
  }
  endpoint_group_region         = data.alicloud_regions.default.regions.0.id
  listener_id                   = alicloud_ga_listener.example.id
  description                   = var.name
  endpoint_group_type           = "virtual"
  endpoint_request_protocol     = "HTTPS"
  health_check_interval_seconds = 4
  health_check_path             = "/path"
  name                          = var.name
  threshold_count               = 4
  traffic_percentage            = 20
  port_overrides {
    endpoint_port = 80
    listener_port = 60
  }
}

resource "alicloud_ga_forwarding_rule" "example" {
  accelerator_id = alicloud_ga_accelerator.example.id
  listener_id    = alicloud_ga_listener.example.id
  rule_conditions {
    rule_condition_type = "Path"
    path_config {
      values = ["/testpathconfig"]
    }
  }
  rule_conditions {
    rule_condition_type = "Host"
    host_config {
      values = ["www.test.com"]
    }
  }
  rule_actions {
    order            = "40"
    rule_action_type = "ForwardGroup"
    forward_group_config {
      server_group_tuples {
        endpoint_group_id = alicloud_ga_endpoint_group.virtual.id
      }
    }
  }
  priority             = 2
  forwarding_rule_name = var.name
}
provider "alicloud" {
  region = "cn-hangzhou"
}
variable "name" {
  default = "tf-example"
}
data "alicloud_regions" "default" {
  current = true
}
resource "random_integer" "default" {
  max = 99999
  min = 10000
}
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "10.4.0.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_zones.default.zones.0.id
}
resource "alicloud_security_group" "default" {
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_sae_namespace" "default" {
  namespace_id              = "${data.alicloud_regions.default.regions.0.id}:example${random_integer.default.result}"
  namespace_name            = var.name
  namespace_description     = var.name
  enable_micro_registration = false
}

resource "alicloud_sae_application" "default" {
  app_description   = var.name
  app_name          = "${var.name}-${random_integer.default.result}"
  namespace_id      = alicloud_sae_namespace.default.id
  image_url         = "registry-vpc.${data.alicloud_regions.default.regions.0.id}.aliyuncs.com/sae-demo-image/consumer:1.0"
  package_type      = "Image"
  security_group_id = alicloud_security_group.default.id
  vpc_id            = alicloud_vpc.default.id
  vswitch_id        = alicloud_vswitch.default.id
  timezone          = "Asia/Beijing"
  replicas          = "5"
  cpu               = "500"
  memory            = "2048"
}

resource "alicloud_sae_application_scaling_rule" "default" {
  app_id                   = alicloud_sae_application.default.id
  scaling_rule_name        = var.name
  scaling_rule_enable      = true
  scaling_rule_type        = "mix"
  min_ready_instances      = "3"
  min_ready_instance_ratio = "-1"
  scaling_rule_timer {
    period = "* * *"
    schedules {
      at_time      = "08:00"
      max_replicas = 10
      min_replicas = 3
    }
    schedules {
      at_time      = "20:00"
      max_replicas = 50
      min_replicas = 3
    }
  }
  scaling_rule_metric {
    max_replicas = 50
    min_replicas = 3
    metrics {
      metric_type                       = "CPU"
      metric_target_average_utilization = 20
    }
    metrics {
      metric_type                       = "MEMORY"
      metric_target_average_utilization = 30
    }
    metrics {
      metric_type                       = "tcpActiveConn"
      metric_target_average_utilization = 20
    }
    scale_up_rules {
      step                         = 10
      disabled                     = false
      stabilization_window_seconds = 0
    }
    scale_down_rules {
      step                         = 10
      disabled                     = false
      stabilization_window_seconds = 10
    }
  }
}
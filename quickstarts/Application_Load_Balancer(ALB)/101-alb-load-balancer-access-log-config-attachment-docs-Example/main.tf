variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

resource "random_integer" "default" {
  min = 100000
  max = 999999
}

resource "alicloud_vpc" "alb_example_tf_vpc" {
  vpc_name   = var.name
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "alb_example_tf_j" {
  vpc_id       = alicloud_vpc.alb_example_tf_vpc.id
  zone_id      = "cn-beijing-j"
  cidr_block   = "192.168.1.0/24"
  vswitch_name = format("%s1", var.name)
}

resource "alicloud_vswitch" "alb_example_tf_k" {
  vpc_id       = alicloud_vpc.alb_example_tf_vpc.id
  zone_id      = "cn-beijing-k"
  cidr_block   = "192.168.2.0/24"
  vswitch_name = format("%s2", var.name)
}

resource "alicloud_vswitch" "defaultDSY0JJ" {
  vpc_id       = alicloud_vpc.alb_example_tf_vpc.id
  zone_id      = "cn-beijing-f"
  cidr_block   = "192.168.3.0/24"
  vswitch_name = format("%s3", var.name)
}

resource "alicloud_alb_load_balancer" "defaultDYswYo" {
  load_balancer_name    = format("%s4", var.name)
  load_balancer_edition = "Standard"
  vpc_id                = alicloud_vpc.alb_example_tf_vpc.id
  load_balancer_billing_config {
    pay_type = "PayAsYouGo"
  }
  address_type           = "Intranet"
  address_allocated_mode = "Fixed"
  zone_mappings {
    vswitch_id = alicloud_vswitch.defaultDSY0JJ.id
    zone_id    = alicloud_vswitch.defaultDSY0JJ.zone_id
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.alb_example_tf_j.id
    zone_id    = alicloud_vswitch.alb_example_tf_j.zone_id
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.alb_example_tf_k.id
    zone_id    = alicloud_vswitch.alb_example_tf_k.zone_id
  }
  lifecycle {
    ignore_changes = [access_log_config]
  }
}


resource "alicloud_alb_load_balancer_access_log_config_attachment" "default" {
  log_store        = "${var.name}-${random_integer.default.result}"
  load_balancer_id = alicloud_alb_load_balancer.defaultDYswYo.id
  log_project      = "${var.name}-${random_integer.default.result}"
}
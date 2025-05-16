variable "name" {
  type    = string
  default = "terraform-example"
}
data "alicloud_resource_manager_resource_groups" "default" {
}

data "alicloud_alb_zones" "default" {
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_vswitch" "default1" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "10.4.1.0/24"
  zone_id      = data.alicloud_alb_zones.default.zones.0.id
  vswitch_name = "${var.name}_1"
}

resource "alicloud_vswitch" "default2" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "10.4.2.0/24"
  zone_id      = data.alicloud_alb_zones.default.zones.1.id
  vswitch_name = "${var.name}_2"
}

resource "alicloud_alb_load_balancer" "default" {
  load_balancer_edition  = "Basic"
  address_type           = "Internet"
  vpc_id                 = alicloud_vpc.default.id
  address_allocated_mode = "Fixed"
  resource_group_id      = data.alicloud_resource_manager_resource_groups.default.groups.0.id
  load_balancer_name     = var.name
  load_balancer_billing_config {
    pay_type = "PayAsYouGo"
  }
  modification_protection_config {
    status = "NonProtection"
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.default1.id
    zone_id    = data.alicloud_alb_zones.default.zones.0.id
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.default2.id
    zone_id    = data.alicloud_alb_zones.default.zones.1.id
  }
  tags = {
    Created = "TF"
  }
}
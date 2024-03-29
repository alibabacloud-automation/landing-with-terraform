variable "name" {
  default = "terraform-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

locals {
  name = "${var.name}-${random_integer.default.result}"
}

data "alicloud_zones" "default" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "default" {
  vpc_name   = local.name
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_zones.default.zones[0].id
  vswitch_name = local.name
}

resource "alicloud_security_group" "default" {
  name   = local.name
  vpc_id = alicloud_vpc.default.id
}

resource "alicloud_slb_load_balancer" "default" {
  count              = 2
  load_balancer_name = format("terraform-example%d", count.index + 1)
  vswitch_id         = alicloud_vswitch.default.id
  load_balancer_spec = "slb.s1.small"
}

resource "alicloud_slb_server_group" "default1" {
  count            = "2"
  load_balancer_id = alicloud_slb_load_balancer.default.0.id
  name             = local.name
}

resource "alicloud_slb_server_group" "default2" {
  count            = "2"
  load_balancer_id = alicloud_slb_load_balancer.default.1.id
  name             = local.name
}

resource "alicloud_slb_listener" "default" {
  count             = 2
  load_balancer_id  = alicloud_slb_load_balancer.default[count.index].id
  backend_port      = "22"
  frontend_port     = "22"
  protocol          = "tcp"
  bandwidth         = "10"
  health_check_type = "tcp"
}

resource "alicloud_ess_scaling_group" "default" {
  min_size           = "2"
  max_size           = "2"
  scaling_group_name = local.name
  default_cooldown   = 200
  removal_policies   = ["OldestInstance"]
  vswitch_ids        = [alicloud_vswitch.default.id]
  loadbalancer_ids   = alicloud_slb_listener.default.*.load_balancer_id
}

resource "alicloud_ess_scalinggroup_vserver_groups" "default" {
  scaling_group_id = alicloud_ess_scaling_group.default.id
  vserver_groups {
    loadbalancer_id = alicloud_slb_load_balancer.default.0.id
    vserver_attributes {
      vserver_group_id = alicloud_slb_server_group.default1.0.id
      port             = "100"
      weight           = "60"
    }
    vserver_attributes {
      vserver_group_id = alicloud_slb_server_group.default1.1.id
      port             = "110"
      weight           = "60"
    }
  }
  vserver_groups {
    loadbalancer_id = alicloud_slb_load_balancer.default.1.id
    vserver_attributes {
      vserver_group_id = alicloud_slb_server_group.default2.0.id
      port             = "200"
      weight           = "60"
    }
    vserver_attributes {
      vserver_group_id = alicloud_slb_server_group.default2.1.id
      port             = "210"
      weight           = "60"
    }
  }
  force = true
}
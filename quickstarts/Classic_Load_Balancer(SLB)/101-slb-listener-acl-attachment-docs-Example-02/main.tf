terraform {
  required_providers {
    alicloud = {
      source = "aliyun/alicloud"
    }
  }
}

variable "name" {
  default = "terraform-exampleSlbListenerAclAck"
}

resource "alicloud_slb_load_balancer" "apiserver" {
  load_balancer_name   = var.name
  internet_charge_type = "PayByTraffic"
  address_type         = "internet"
  load_balancer_spec   = "slb.s1.small"
}

resource "alicloud_slb_listener" "apiserver" {
  load_balancer_id = alicloud_slb_load_balancer.apiserver.id
  backend_port     = 6443
  frontend_port    = 6443
  protocol         = "tcp"
  bandwidth        = 10
  health_check     = "on"

  lifecycle {
    ignore_changes = [acl_status, acl_type, acl_ids]
  }
}

resource "alicloud_slb_listener" "other" {
  load_balancer_id = alicloud_slb_load_balancer.apiserver.id
  backend_port     = 80
  frontend_port    = 80
  protocol         = "http"
  bandwidth        = 10
}

resource "alicloud_slb_acl" "apiserver" {
  name       = "${var.name}-acl"
  ip_version = "ipv4"
}

resource "alicloud_slb_acl_entry_attachment" "apiserver" {
  acl_id = alicloud_slb_acl.apiserver.id
  entries {
    entry = "10.10.10.0/24"
  }
}

data "alicloud_slb_listeners" "apiserver" {
  load_balancer_id = alicloud_slb_load_balancer.apiserver.id
  # Referring to the listener attributes makes the query wait until the
  # listeners exist, so the result does not depend on creation order.
  protocol      = alicloud_slb_listener.apiserver.protocol
  frontend_port = alicloud_slb_listener.apiserver.frontend_port
}

resource "alicloud_slb_listener_acl_attachment" "apiserver" {
  # The filters above identify the listener by protocol and frontend port; a
  # load balancer exposes at most one listener per protocol and port. `one`
  # keeps the example from silently using the first of several matches.
  listener_id = one([for listener in data.alicloud_slb_listeners.apiserver.slb_listeners : listener.id])
  acl_id      = alicloud_slb_acl.apiserver.id
  acl_type    = "white"

  lifecycle {
    precondition {
      condition     = length(data.alicloud_slb_listeners.apiserver.slb_listeners) == 1
      error_message = "The protocol and frontend_port filters must match exactly one listener; check the input variables before binding the policy group."
    }
  }
}
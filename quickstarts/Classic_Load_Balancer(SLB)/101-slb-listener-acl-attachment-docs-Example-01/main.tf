terraform {
  required_providers {
    alicloud = {
      source = "aliyun/alicloud"
    }
  }
}

variable "name" {
  default = "terraform-exampleSlbListenerAcl"
}

resource "alicloud_slb_load_balancer" "default" {
  load_balancer_name   = var.name
  internet_charge_type = "PayByTraffic"
  address_type         = "internet"
  load_balancer_spec   = "slb.s1.small"
}

resource "alicloud_slb_listener" "default" {
  load_balancer_id          = alicloud_slb_load_balancer.default.id
  backend_port              = 80
  frontend_port             = 80
  protocol                  = "http"
  bandwidth                 = 10
  health_check              = "on"
  health_check_uri          = "/cons"
  health_check_connect_port = 20
  healthy_threshold         = 8
  unhealthy_threshold       = 8
  health_check_timeout      = 8
  health_check_interval     = 5

  lifecycle {
    # The attachment resource owns the access control settings of this listener.
    # `acl_id` is deprecated, so only the current arguments are ignored.
    ignore_changes = [acl_status, acl_type, acl_ids]

    precondition {
      condition     = alicloud_slb_acl.default.id != ""
      error_message = "The policy group must exist before the listener so that destroying the listener releases the ACL association first."
    }
  }
}

resource "alicloud_slb_acl" "default" {
  name       = "${var.name}-acl"
  ip_version = "ipv4"
}

resource "alicloud_slb_acl_entry_attachment" "default" {
  acl_id = alicloud_slb_acl.default.id
  entries {
    entry   = "10.10.10.0/24"
    comment = "example entry"
  }
}

resource "alicloud_slb_listener_acl_attachment" "default" {
  listener_id = alicloud_slb_listener.default.id
  acl_id      = alicloud_slb_acl.default.id
  acl_type    = "white"
}
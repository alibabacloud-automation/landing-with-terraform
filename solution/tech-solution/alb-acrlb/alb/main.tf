variable "vpc_id" {}
variable "vsw1_id" {}
variable "zone11_id" {}
variable "vsw2_id" {}
variable "zone12_id" {}
variable "ecs2_ip" {}
variable "ecs3_ip" {}

resource "alicloud_alb_load_balancer" "alb" {
  vpc_id                 = var.vpc_id
  address_type           = "Intranet"
  address_allocated_mode = "Fixed"
  load_balancer_name     = "alb_name"
  load_balancer_edition  = "Basic"
  load_balancer_billing_config {
    pay_type = "PayAsYouGo"
  }
  zone_mappings {
    vswitch_id = var.vsw1_id
    zone_id    = var.zone11_id
  }
  zone_mappings {
    vswitch_id = var.vsw2_id
    zone_id    = var.zone12_id
  }
}

resource "alicloud_alb_server_group" "alb_rs" {
  protocol          = "HTTP"
  vpc_id            = var.vpc_id
  server_group_name = "rs_test"
  server_group_type = "Ip"
  health_check_config {
    health_check_enabled = false
  }
  sticky_session_config {
    sticky_session_enabled = false
  }
  servers {
    port              = 80
    server_id         = var.ecs2_ip
    server_ip         = var.ecs2_ip
    server_type       = "Ip"
    remote_ip_enabled = true
    weight            = 100
  }
  servers {
    port              = 80
    server_id         = var.ecs3_ip
    server_ip         = var.ecs3_ip
    server_type       = "Ip"
    remote_ip_enabled = true
    weight            = 100
  }
}

resource "alicloud_alb_listener" "alb_listener" {
  load_balancer_id  = alicloud_alb_load_balancer.alb.id
  listener_protocol = "HTTP"
  listener_port     = 80
  default_actions {
    type = "ForwardGroup"
    forward_group_config {
      server_group_tuples {
        server_group_id = alicloud_alb_server_group.alb_rs.id
      }
    }
  }
}

output "alb_dns_name" {
  value = alicloud_alb_load_balancer.alb.dns_name
}
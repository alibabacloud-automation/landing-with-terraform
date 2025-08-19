# ALB 相关资源
resource "alicloud_alb_load_balancer" "alb" {
  provider               = alicloud.region1
  vpc_id                 = alicloud_vpc.vpc1.id
  address_type           = "Intranet"
  address_allocated_mode = "Fixed"
  load_balancer_name     = "alb_name"
  load_balancer_edition  = "Basic"
  load_balancer_billing_config {
    pay_type = "PayAsYouGo"
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.vsw11.id
    zone_id    = var.zone11_id
  }
  zone_mappings {
    vswitch_id = alicloud_vswitch.vsw12.id
    zone_id    = var.zone12_id
  }
}

resource "alicloud_alb_server_group" "alb_rs" {
  provider          = alicloud.region1
  protocol          = "HTTP"
  vpc_id            = alicloud_vpc.vpc1.id
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
    server_id         = alicloud_instance.ecs2.private_ip
    server_ip         = alicloud_instance.ecs2.private_ip
    server_type       = "Ip"
    remote_ip_enabled = true
    weight            = 100
  }
  servers {
    port              = 80
    server_id         = alicloud_instance.ecs3.private_ip
    server_ip         = alicloud_instance.ecs3.private_ip
    server_type       = "Ip"
    remote_ip_enabled = true
    weight            = 100
  }
}

resource "alicloud_alb_listener" "alb_listener" {
  provider          = alicloud.region1
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
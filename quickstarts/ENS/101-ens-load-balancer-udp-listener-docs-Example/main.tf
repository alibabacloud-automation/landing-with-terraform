variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "ens_region_id" {
  default = "cn-chenzhou-telecom_unicom_cmcc"
}

resource "alicloud_ens_network" "default" {
  network_name  = var.name
  cidr_block    = "10.0.0.0/8"
  ens_region_id = var.ens_region_id
}

resource "alicloud_ens_vswitch" "default" {
  cidr_block    = "10.0.6.0/24"
  vswitch_name  = var.name
  ens_region_id = alicloud_ens_network.default.ens_region_id
  network_id    = alicloud_ens_network.default.id
}

resource "alicloud_ens_load_balancer" "default" {
  load_balancer_name = var.name
  vswitch_id         = alicloud_ens_vswitch.default.id
  payment_type       = "PayAsYouGo"
  ens_region_id      = alicloud_ens_vswitch.default.ens_region_id
  network_id         = alicloud_ens_vswitch.default.network_id
  load_balancer_spec = "elb.s1.small"
}

resource "alicloud_ens_load_balancer_udp_listener" "default" {
  load_balancer_id             = alicloud_ens_load_balancer.default.id
  listener_port                = 53
  backend_server_port          = 53
  description                  = "example-udp-listener"
  scheduler                    = "wrr"
  healthy_threshold            = 2
  unhealthy_threshold          = 2
  health_check_connect_timeout = 5
  health_check_interval        = 2
  health_check_connect_port    = 53
  health_check_req             = "hello"
  health_check_exp             = "rep"
  eip_transmit                 = "off"
  established_timeout          = 900
  status                       = "Stopped"
}
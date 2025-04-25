variable "name" {
  default = "terraform-example"
}

variable "zone_id1" {
  default = "cn-wulanchabu-b"
}

provider "alicloud" {
  region = "cn-wulanchabu"
}

data "alicloud_resource_manager_resource_groups" "default" {}

resource "alicloud_vpc" "default" {
  cidr_block = "10.0.0.0/8"
  vpc_name   = var.name
}

resource "alicloud_vswitch" "default" {
  vpc_id       = alicloud_vpc.default.id
  zone_id      = var.zone_id1
  cidr_block   = "10.0.0.0/24"
  vswitch_name = format("%s1", var.name)
}

resource "alicloud_gwlb_load_balancer" "default" {
  vpc_id             = alicloud_vpc.default.id
  load_balancer_name = format("%s3", var.name)
  zone_mappings {
    vswitch_id = alicloud_vswitch.default.id
    zone_id    = var.zone_id1
  }
  address_ip_version = "Ipv4"
}

resource "alicloud_gwlb_server_group" "default" {
  protocol          = "GENEVE"
  server_group_name = "tfaccgwlb62413"
  server_group_type = "Ip"
  servers {
    server_id   = "10.0.0.1"
    server_ip   = "10.0.0.1"
    server_type = "Ip"
  }
  servers {
    server_id   = "10.0.0.2"
    server_ip   = "10.0.0.2"
    server_type = "Ip"
  }
  servers {
    server_id   = "10.0.0.3"
    server_ip   = "10.0.0.3"
    server_type = "Ip"
  }

  connection_drain_config {
    connection_drain_enabled = "true"
    connection_drain_timeout = "1"
  }

  resource_group_id = data.alicloud_resource_manager_resource_groups.default.ids.0
  dry_run           = "false"
  health_check_config {
    health_check_protocol = "HTTP"
    health_check_http_code = [
      "http_2xx",
      "http_3xx",
      "http_4xx"
    ]
    health_check_interval        = "10"
    health_check_path            = "/health-check"
    unhealthy_threshold          = "2"
    health_check_connect_port    = "80"
    health_check_connect_timeout = "5"
    health_check_domain          = "www.domain.com"
    health_check_enabled         = "true"
    healthy_threshold            = "2"
  }

  vpc_id    = alicloud_vpc.default.id
  scheduler = "5TCH"
}

resource "alicloud_gwlb_listener" "default" {
  listener_description = "example-tf-lsn"
  server_group_id      = alicloud_gwlb_server_group.default.id
  load_balancer_id     = alicloud_gwlb_load_balancer.default.id
}
variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-wulanchabu"
}

variable "region_id" {
  default = "cn-wulanchabu"
}

variable "zone_id1" {
  default = "cn-wulanchabu-b"
}

data "alicloud_resource_manager_resource_groups" "default" {}

resource "alicloud_vpc" "defaultEaxcvb" {
  cidr_block = "10.0.0.0/8"
  vpc_name   = "tf-gwlb-vpc"
}

resource "alicloud_vswitch" "defaultc3uVID" {
  vpc_id       = alicloud_vpc.defaultEaxcvb.id
  zone_id      = var.zone_id1
  cidr_block   = "10.0.0.0/24"
  vswitch_name = "tf-example-vsw1"
}

resource "alicloud_security_group" "default7NNxRl" {
  description         = "sg"
  security_group_name = "sg_name"
  vpc_id              = alicloud_vpc.defaultEaxcvb.id
  security_group_type = "normal"
}

resource "alicloud_instance" "defaultH6McvC" {
  vswitch_id = alicloud_vswitch.defaultc3uVID.id
  image_id   = "aliyun_2_1903_x64_20G_alibase_20231221.vhd"

  instance_type        = "ecs.g6.large"
  system_disk_category = "cloud_efficiency"

  internet_charge_type       = "PayByTraffic"
  internet_max_bandwidth_out = 5
  instance_name              = format("%s4", var.name)
  description                = "tf-example-ecs"
  security_groups            = [alicloud_security_group.default7NNxRl.id]

  availability_zone    = alicloud_vswitch.defaultc3uVID.zone_id
  instance_charge_type = "PostPaid"
}

resource "alicloud_gwlb_server_group" "default" {
  dry_run = "false"
  servers {
    server_id   = alicloud_instance.defaultH6McvC.id
    server_type = "Ecs"
  }

  scheduler = "5TCH"
  protocol  = "GENEVE"
  connection_drain_config {
    connection_drain_enabled = "true"
    connection_drain_timeout = "1"
  }

  vpc_id            = alicloud_vpc.defaultEaxcvb.id
  server_group_type = "Instance"
  server_group_name = var.name
  health_check_config {
    health_check_connect_port    = "80"
    health_check_enabled         = "true"
    health_check_protocol        = "HTTP"
    health_check_connect_timeout = "5"
    health_check_domain          = "www.domain.com"
    health_check_http_code = [
      "http_2xx",
      "http_3xx",
      "http_4xx"
    ]
    health_check_interval = "10"
    health_check_path     = "/health-check"
    healthy_threshold     = "2"
    unhealthy_threshold   = "2"
  }

  resource_group_id = data.alicloud_resource_manager_resource_groups.default.ids.0
}
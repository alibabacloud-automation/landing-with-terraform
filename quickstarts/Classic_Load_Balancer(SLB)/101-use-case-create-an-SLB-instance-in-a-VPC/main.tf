provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_vpc" "main" {
  vpc_name = "alicloud"
  # 专有网络地址块
  cidr_block = "10.1.0.0/21"
}

resource "alicloud_vswitch" "main" {
  vpc_id = alicloud_vpc.main.id
  # 交换机地址块
  cidr_block = "10.1.0.0/24"
  # 可用区
  zone_id = "cn-hangzhou-b"
}

resource "alicloud_slb_load_balancer" "instance" {
  load_balancer_name   = "slb_worder"
  load_balancer_spec   = "slb.s3.small"
  internet_charge_type = "PayByTraffic"
  address_type         = "internet"
  vswitch_id           = alicloud_vswitch.main.id
}

resource "alicloud_slb_listener" "listener" {
  load_balancer_id = alicloud_slb_load_balancer.instance.id
  backend_port     = "2111"
  frontend_port    = "21"
  protocol         = "tcp"
  bandwidth        = "5"
}
data "alicloud_zones" "ms_server_group" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
}

data "alicloud_instance_types" "ms_server_group" {
  availability_zone = data.alicloud_zones.ms_server_group.zones[0].id
  eni_amount        = 2
}

data "alicloud_images" "image" {
  name_regex  = "^ubuntu_18.*64"
  most_recent = true
  owners      = "system"
}

variable "slb_master_slave_server_group" {
  default = "forSlbMasterSlaveServerGroup"
}

resource "alicloud_vpc" "main" {
  vpc_name   = var.slb_master_slave_server_group
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "main" {
  vpc_id       = alicloud_vpc.main.id
  cidr_block   = "172.16.0.0/16"
  zone_id      = data.alicloud_zones.ms_server_group.zones[0].id
  vswitch_name = var.slb_master_slave_server_group
}

resource "alicloud_security_group" "group" {
  name   = var.slb_master_slave_server_group
  vpc_id = alicloud_vpc.main.id
}

resource "alicloud_instance" "ms_server_group" {
  image_id                   = data.alicloud_images.image.images[0].id
  instance_type              = data.alicloud_instance_types.ms_server_group.instance_types[0].id
  instance_name              = var.slb_master_slave_server_group
  count                      = 2
  security_groups            = [alicloud_security_group.group.id]
  internet_charge_type       = "PayByTraffic"
  internet_max_bandwidth_out = "10"
  availability_zone          = data.alicloud_zones.ms_server_group.zones[0].id
  instance_charge_type       = "PostPaid"
  system_disk_category       = "cloud_efficiency"
  vswitch_id                 = alicloud_vswitch.main.id
}

resource "alicloud_slb_load_balancer" "ms_server_group" {
  load_balancer_name = var.slb_master_slave_server_group
  vswitch_id         = alicloud_vswitch.main.id
  load_balancer_spec = "slb.s2.small"
}

resource "alicloud_ecs_network_interface" "ms_server_group" {
  network_interface_name = var.slb_master_slave_server_group
  vswitch_id             = alicloud_vswitch.main.id
  security_group_ids     = [alicloud_security_group.group.id]
}

resource "alicloud_ecs_network_interface_attachment" "ms_server_group" {
  instance_id          = alicloud_instance.ms_server_group[0].id
  network_interface_id = alicloud_ecs_network_interface.ms_server_group.id
}

resource "alicloud_slb_master_slave_server_group" "group" {
  load_balancer_id = alicloud_slb_load_balancer.ms_server_group.id
  name             = var.slb_master_slave_server_group

  servers {
    server_id   = alicloud_instance.ms_server_group[0].id
    port        = 100
    weight      = 100
    server_type = "Master"
  }

  servers {
    server_id   = alicloud_instance.ms_server_group[1].id
    port        = 100
    weight      = 100
    server_type = "Slave"
  }
}

resource "alicloud_slb_listener" "tcp" {
  load_balancer_id             = alicloud_slb_load_balancer.ms_server_group.id
  master_slave_server_group_id = alicloud_slb_master_slave_server_group.group.id
  frontend_port                = "22"
  protocol                     = "tcp"
  bandwidth                    = "10"
  health_check_type            = "tcp"
  persistence_timeout          = 3600
  healthy_threshold            = 8
  unhealthy_threshold          = 8
  health_check_timeout         = 8
  health_check_interval        = 5
  health_check_http_code       = "http_2xx"
  health_check_connect_port    = 20
  health_check_uri             = "/console"
  established_timeout          = 600
}
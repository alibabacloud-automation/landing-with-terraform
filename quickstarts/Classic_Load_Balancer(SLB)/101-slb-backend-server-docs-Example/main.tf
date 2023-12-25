// alicloud_slb_backend_server
variable "slb_backend_server_name" {
  default = "slbbackendservertest"
}

data "alicloud_zones" "backend_server" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
}

data "alicloud_instance_types" "backend_server" {
  availability_zone = data.alicloud_zones.backend_server.zones[0].id
  cpu_core_count    = 1
  memory_size       = 2
}

data "alicloud_images" "backend_server" {
  name_regex  = "^ubuntu_18.*64"
  most_recent = true
  owners      = "system"
}

resource "alicloud_vpc" "backend_server" {
  vpc_name   = var.slb_backend_server_name
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "backend_server" {
  vpc_id       = alicloud_vpc.backend_server.id
  cidr_block   = "172.16.0.0/16"
  zone_id      = data.alicloud_zones.backend_server.zones[0].id
  vswitch_name = var.slb_backend_server_name
}

resource "alicloud_security_group" "backend_server" {
  name   = var.slb_backend_server_name
  vpc_id = alicloud_vpc.backend_server.id
}

resource "alicloud_instance" "backend_server" {
  image_id                   = data.alicloud_images.backend_server.images[0].id
  instance_type              = data.alicloud_instance_types.backend_server.instance_types[0].id
  instance_name              = var.slb_backend_server_name
  count                      = "2"
  security_groups            = alicloud_security_group.backend_server.*.id
  internet_charge_type       = "PayByTraffic"
  internet_max_bandwidth_out = "10"
  availability_zone          = data.alicloud_zones.backend_server.zones[0].id
  instance_charge_type       = "PostPaid"
  system_disk_category       = "cloud_efficiency"
  vswitch_id                 = alicloud_vswitch.backend_server.id
}

resource "alicloud_slb_load_balancer" "backend_server" {
  load_balancer_name   = var.slb_backend_server_name
  vswitch_id           = alicloud_vswitch.backend_server.id
  instance_charge_type = "PayByCLCU"
}

resource "alicloud_slb_backend_server" "backend_server" {
  load_balancer_id = alicloud_slb_load_balancer.backend_server.id

  backend_servers {
    server_id = alicloud_instance.backend_server[0].id
    weight    = 100
  }

  backend_servers {
    server_id = alicloud_instance.backend_server[1].id
    weight    = 100
  }
}
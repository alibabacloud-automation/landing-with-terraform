variable "slb_server_group_server_attachment" {
  default = "terraform-example"
}

variable "slb_server_group_server_attachment_count" {
  default = 5
}

data "alicloud_zones" "server_attachment" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
}

data "alicloud_instance_types" "server_attachment" {
  availability_zone = data.alicloud_zones.server_attachment.zones[0].id
  cpu_core_count    = 1
  memory_size       = 2
}

data "alicloud_images" "server_attachment" {
  name_regex  = "^ubuntu_[0-9]+_[0-9]+_x64*"
  most_recent = true
  owners      = "system"
}


resource "alicloud_vpc" "server_attachment" {
  vpc_name   = var.slb_server_group_server_attachment
  cidr_block = "172.17.3.0/24"
}

resource "alicloud_vswitch" "server_attachment" {
  vswitch_name = var.slb_server_group_server_attachment
  cidr_block   = "172.17.3.0/24"
  vpc_id       = alicloud_vpc.server_attachment.id
  zone_id      = data.alicloud_zones.server_attachment.zones.0.id
}

resource "alicloud_security_group" "server_attachment" {
  name   = var.slb_server_group_server_attachment
  vpc_id = alicloud_vpc.server_attachment.id
}

resource "alicloud_instance" "server_attachment" {
  count                      = var.slb_server_group_server_attachment_count
  image_id                   = data.alicloud_images.server_attachment.images[0].id
  instance_type              = data.alicloud_instance_types.server_attachment.instance_types[0].id
  instance_name              = var.slb_server_group_server_attachment
  security_groups            = alicloud_security_group.server_attachment.*.id
  internet_charge_type       = "PayByTraffic"
  internet_max_bandwidth_out = "10"
  availability_zone          = data.alicloud_zones.server_attachment.zones[0].id
  instance_charge_type       = "PostPaid"
  system_disk_category       = "cloud_efficiency"
  vswitch_id                 = alicloud_vswitch.server_attachment.id
}

resource "alicloud_slb_load_balancer" "server_attachment" {
  load_balancer_name = var.slb_server_group_server_attachment
  vswitch_id         = alicloud_vswitch.server_attachment.id
  load_balancer_spec = "slb.s2.small"
  address_type       = "intranet"
}

resource "alicloud_slb_server_group" "server_attachment" {
  load_balancer_id = alicloud_slb_load_balancer.server_attachment.id
  name             = var.slb_server_group_server_attachment
}

resource "alicloud_slb_server_group_server_attachment" "server_attachment" {
  count           = var.slb_server_group_server_attachment_count
  server_group_id = alicloud_slb_server_group.server_attachment.id
  server_id       = alicloud_instance.server_attachment[count.index].id
  port            = 8080
  weight          = 0
}
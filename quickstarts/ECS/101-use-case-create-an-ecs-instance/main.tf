variable "region" {
  default = "cn-beijing"
}

variable "instance_type" {
  default = "ecs.n4.large"
}

variable "image_id" {
  default = "ubuntu_18_04_64_20G_alibase_20190624.vhd"
}

provider "alicloud" {
  region = var.region
}

data "alicloud_zones" "default" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.instance_type
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "tf_test_foo"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id     = alicloud_vpc.vpc.id
  cidr_block = "172.16.0.0/21"
  zone_id    = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "default" {
  security_group_name = "default"
  vpc_id              = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "allow_all_tcp" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 1
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_instance" "instance" {
  # cn-beijing
  availability_zone = data.alicloud_zones.default.zones.0.id
  security_groups   = alicloud_security_group.default.*.id
  # series III
  instance_type              = var.instance_type
  system_disk_category       = "cloud_efficiency"
  image_id                   = var.image_id
  instance_name              = "test_foo"
  vswitch_id                 = alicloud_vswitch.vsw.id
  internet_max_bandwidth_out = 10
}

output "public_ip" {
  value = alicloud_instance.instance.public_ip
}
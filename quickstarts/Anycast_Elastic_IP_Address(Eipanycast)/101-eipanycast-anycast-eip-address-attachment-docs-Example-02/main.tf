variable "name" {
  default = "tf-example"
}

provider "alicloud" {
  alias  = "beijing"
  region = "cn-beijing"
}

provider "alicloud" {
  alias  = "hangzhou"
  region = "cn-hangzhou"
}

data "alicloud_zones" "default" {
  provider                    = "alicloud.beijing"
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
}

data "alicloud_images" "default" {
  provider    = "alicloud.beijing"
  name_regex  = "^ubuntu_18.*64"
  most_recent = true
  owners      = "system"
}

data "alicloud_instance_types" "default" {
  provider          = "alicloud.beijing"
  availability_zone = data.alicloud_zones.default.zones[0].id
  cpu_core_count    = 1
  memory_size       = 2
}

resource "alicloud_vpc" "defaultVpc" {
  provider   = "alicloud.beijing"
  vpc_name   = var.name
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_vswitch" "defaultVsw" {
  provider   = "alicloud.beijing"
  vpc_id     = alicloud_vpc.defaultVpc.id
  cidr_block = "192.168.0.0/24"
  zone_id    = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "defaultuBsECI" {
  provider = "alicloud.beijing"
  vpc_id   = alicloud_vpc.defaultVpc.id
}

resource "alicloud_instance" "default9KDlN7" {
  provider             = "alicloud.beijing"
  image_id             = data.alicloud_images.default.images[0].id
  instance_type        = data.alicloud_instance_types.default.instance_types[0].id
  instance_name        = var.name
  security_groups      = ["${alicloud_security_group.defaultuBsECI.id}"]
  availability_zone    = alicloud_vswitch.defaultVsw.zone_id
  instance_charge_type = "PostPaid"
  system_disk_category = "cloud_efficiency"
  vswitch_id           = alicloud_vswitch.defaultVsw.id
}

resource "alicloud_eipanycast_anycast_eip_address" "defaultXkpFRs" {
  provider         = "alicloud.hangzhou"
  service_location = "ChineseMainland"
}

resource "alicloud_vpc" "defaultVpc2" {
  provider   = "alicloud.hangzhou"
  vpc_name   = "${var.name}6"
  cidr_block = "192.168.0.0/16"
}

data "alicloud_zones" "default2" {
  provider                    = "alicloud.hangzhou"
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
}

data "alicloud_images" "default2" {
  provider    = "alicloud.hangzhou"
  name_regex  = "^ubuntu_18.*64"
  most_recent = true
  owners      = "system"
}

data "alicloud_instance_types" "default2" {
  provider          = "alicloud.hangzhou"
  availability_zone = data.alicloud_zones.default2.zones[0].id
  cpu_core_count    = 1
  memory_size       = 2
}

resource "alicloud_vswitch" "defaultdsVsw2" {
  provider   = "alicloud.hangzhou"
  vpc_id     = alicloud_vpc.defaultVpc2.id
  cidr_block = "192.168.0.0/24"
  zone_id    = data.alicloud_zones.default2.zones.1.id
}

resource "alicloud_security_group" "defaultuBsECI2" {
  provider = "alicloud.hangzhou"
  vpc_id   = alicloud_vpc.defaultVpc2.id
}

resource "alicloud_instance" "defaultEcs2" {
  provider             = "alicloud.hangzhou"
  image_id             = data.alicloud_images.default2.images[0].id
  instance_type        = data.alicloud_instance_types.default2.instance_types[0].id
  instance_name        = var.name
  security_groups      = ["${alicloud_security_group.defaultuBsECI2.id}"]
  availability_zone    = alicloud_vswitch.defaultdsVsw2.zone_id
  instance_charge_type = "PostPaid"
  system_disk_category = "cloud_efficiency"
  vswitch_id           = alicloud_vswitch.defaultdsVsw2.id
}

resource "alicloud_eipanycast_anycast_eip_address_attachment" "defaultEfYBJY" {
  provider                = "alicloud.beijing"
  bind_instance_id        = alicloud_instance.default9KDlN7.network_interface_id
  bind_instance_type      = "NetworkInterface"
  bind_instance_region_id = "cn-beijing"
  anycast_id              = alicloud_eipanycast_anycast_eip_address.defaultXkpFRs.id
  association_mode        = "Default"
}

resource "alicloud_eipanycast_anycast_eip_address_attachment" "normal" {
  provider                = "alicloud.hangzhou"
  bind_instance_id        = alicloud_instance.defaultEcs2.network_interface_id
  bind_instance_type      = "NetworkInterface"
  bind_instance_region_id = "cn-hangzhou"
  anycast_id              = alicloud_eipanycast_anycast_eip_address_attachment.defaultEfYBJY.anycast_id
}
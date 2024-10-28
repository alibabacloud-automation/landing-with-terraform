variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "region_id" {
  default = "cn-hangzhou"
}

variable "azone" {
  default = "cn-hangzhou-g"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "defaultkyVC70" {
  cidr_block  = "172.16.0.0/12"
  description = "接入点测试noRootDirectory"
}

resource "alicloud_vswitch" "defaultoZAPmO" {
  vpc_id     = alicloud_vpc.defaultkyVC70.id
  zone_id    = data.alicloud_zones.default.zones.0.id
  cidr_block = "172.16.0.0/24"
}

resource "alicloud_nas_access_group" "defaultBbc7ev" {
  access_group_type = "Vpc"
  access_group_name = var.name
  file_system_type  = "standard"
}

resource "alicloud_nas_file_system" "defaultVtUpDh" {
  storage_type     = "Performance"
  zone_id          = var.azone
  encrypt_type     = "0"
  protocol_type    = "NFS"
  file_system_type = "standard"
  description      = "AccessPointnoRootDirectory"
}


resource "alicloud_nas_access_point" "default" {
  vpc_id            = alicloud_vpc.defaultkyVC70.id
  access_group      = alicloud_nas_access_group.defaultBbc7ev.access_group_name
  vswitch_id        = alicloud_vswitch.defaultoZAPmO.id
  file_system_id    = alicloud_nas_file_system.defaultVtUpDh.id
  access_point_name = var.name
  posix_user {
    posix_group_id = "123"
    posix_user_id  = "123"
  }
  root_path_permission {
    owner_group_id = "1"
    owner_user_id  = "1"
    permission     = "0777"
  }
}
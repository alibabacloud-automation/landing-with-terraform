variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

resource "alicloud_vpc" "example" {
  is_default  = false
  cidr_block  = "192.168.0.0/16"
  vpc_name    = "nas-examplee1223-vpc"
  enable_ipv6 = true
}

resource "alicloud_vswitch" "example" {
  is_default   = false
  vpc_id       = alicloud_vpc.example.id
  zone_id      = "cn-beijing-i"
  cidr_block   = "192.168.3.0/24"
  vswitch_name = "nas-examplee1223-vsw2sdw-C"
}

resource "alicloud_nas_file_system" "example" {
  description      = var.name
  storage_type     = "advance_100"
  zone_id          = "cn-beijing-i"
  vpc_id           = alicloud_vpc.example.id
  capacity         = "3600"
  protocol_type    = "cpfs"
  vswitch_id       = alicloud_vswitch.example.id
  file_system_type = "cpfs"
}

resource "alicloud_nas_protocol_service" "example" {
  vpc_id         = alicloud_vpc.example.id
  protocol_type  = "NFS"
  protocol_spec  = "General"
  vswitch_id     = alicloud_vswitch.example.id
  dry_run        = false
  file_system_id = alicloud_nas_file_system.example.id
}

resource "alicloud_nas_fileset" "example" {
  file_system_path = "/examplefileset/"
  description      = "cpfs-LRS-filesetexample-wyf"
  file_system_id   = alicloud_nas_file_system.example.id
}


resource "alicloud_nas_protocol_mount_target" "default" {
  fset_id             = alicloud_nas_fileset.example.fileset_id
  description         = var.name
  vpc_id              = alicloud_vpc.example.id
  vswitch_id          = alicloud_vswitch.example.id
  access_group_name   = "DEFAULT_VPC_GROUP_NAME"
  dry_run             = false
  file_system_id      = alicloud_nas_file_system.example.id
  protocol_service_id = alicloud_nas_protocol_service.example.protocol_service_id
}
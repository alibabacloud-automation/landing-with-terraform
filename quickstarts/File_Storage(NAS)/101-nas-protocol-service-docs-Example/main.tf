variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

resource "alicloud_vpc" "example" {
  is_default  = false
  cidr_block  = "192.168.0.0/16"
  vpc_name    = "nas-examplee1031-vpc"
  enable_ipv6 = true
}

resource "alicloud_vswitch" "example" {
  is_default   = false
  vpc_id       = alicloud_vpc.example.id
  zone_id      = "cn-beijing-i"
  cidr_block   = "192.168.2.0/24"
  vswitch_name = "nas-examplee1031-vsw1sdw-F"
}

resource "alicloud_nas_file_system" "example" {
  description      = var.name
  storage_type     = "advance_100"
  zone_id          = "cn-beijing-i"
  encrypt_type     = "0"
  vpc_id           = alicloud_vpc.example.id
  capacity         = "3600"
  protocol_type    = "cpfs"
  vswitch_id       = alicloud_vswitch.example.id
  file_system_type = "cpfs"
}


resource "alicloud_nas_protocol_service" "default" {
  vpc_id         = alicloud_vpc.example.id
  protocol_type  = "NFS"
  protocol_spec  = "General"
  vswitch_id     = alicloud_vswitch.example.id
  dry_run        = false
  file_system_id = alicloud_nas_file_system.example.id
}
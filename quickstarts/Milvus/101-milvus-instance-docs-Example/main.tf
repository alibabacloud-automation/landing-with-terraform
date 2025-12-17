variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "region_id" {
  default = "cn-hangzhou"
}

variable "zone_id" {
  default = "cn-hangzhou-j"
}

resource "alicloud_vpc" "defaultILXuit" {
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "defaultN80M7S" {
  vpc_id       = alicloud_vpc.defaultILXuit.id
  zone_id      = var.zone_id
  cidr_block   = "172.16.1.0/24"
  vswitch_name = "milvus-example"
}


resource "alicloud_milvus_instance" "default" {
  zone_id = var.zone_id
  vswitch_ids {
    vsw_id  = alicloud_vswitch.defaultN80M7S.id
    zone_id = alicloud_vswitch.defaultN80M7S.zone_id
  }
  db_admin_password = "Test123456@"
  components {
    type    = "standalone"
    cu_num  = "8"
    replica = "1"
    cu_type = "general"
  }
  instance_name         = "镇远测试包年包月"
  db_version            = "2.4"
  vpc_id                = alicloud_vpc.defaultILXuit.id
  ha                    = false
  payment_type          = "Subscription"
  multi_zone_mode       = "Single"
  payment_duration_unit = "year"
  payment_duration      = "1"
}
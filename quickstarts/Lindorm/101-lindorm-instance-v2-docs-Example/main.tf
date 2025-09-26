variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

resource "alicloud_vpc" "defaultR8vXlP" {
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_vswitch" "default9umuzwH" {
  vpc_id     = alicloud_vpc.defaultR8vXlP.id
  zone_id    = "cn-beijing-h"
  cidr_block = "172.16.0.0/24"
}

resource "alicloud_vswitch" "defaultgOFAo3L" {
  vpc_id     = alicloud_vpc.defaultR8vXlP.id
  zone_id    = "cn-beijing-l"
  cidr_block = "172.16.1.0/24"
}

resource "alicloud_vswitch" "defaultTAbr2pJ" {
  vpc_id     = alicloud_vpc.defaultR8vXlP.id
  zone_id    = "cn-beijing-j"
  cidr_block = "172.16.2.0/24"
}


resource "alicloud_lindorm_instance_v2" "default" {
  standby_zone_id = "cn-beijing-l"
  engine_list {
    engine_type = "TABLE"
    node_group {
      node_count          = "4"
      node_spec           = "lindorm.g.2xlarge"
      resource_group_name = "cx-mz-rg"
    }
  }
  cloud_storage_size = "400"
  primary_zone_id    = "cn-beijing-h"
  zone_id            = "cn-beijing-h"
  cloud_storage_type = "PerformanceStorage"
  arch_version       = "2.0"
  vswitch_id         = alicloud_vswitch.default9umuzwH.id
  standby_vswitch_id = alicloud_vswitch.defaultgOFAo3L.id
  primary_vswitch_id = alicloud_vswitch.default9umuzwH.id
  arbiter_vswitch_id = alicloud_vswitch.defaultTAbr2pJ.id
  vpc_id             = alicloud_vpc.defaultR8vXlP.id
  instance_alias     = "preTest-MZ"
  payment_type       = "POSTPAY"
  arbiter_zone_id    = "cn-beijing-j"
  auto_renewal       = false
}
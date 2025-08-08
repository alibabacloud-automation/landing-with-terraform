variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_resource_manager_resource_groups" "default" {}

resource "alicloud_vpc" "defaultB21JUD" {
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "default106DkE" {
  vpc_id       = alicloud_vpc.defaultB21JUD.id
  cidr_block   = "172.16.1.0/24"
  vswitch_name = "sr-example"
  zone_id      = "cn-hangzhou-i"
}


resource "alicloud_star_rocks_instance" "default" {
  instance_name = "create-instance-1"
  auto_renew    = false
  frontend_node_groups {
    cu                          = "8"
    storage_size                = "100"
    resident_node_number        = "3"
    storage_performance_level   = "pl1"
    spec_type                   = "standard"
    disk_number                 = "1"
    zone_id                     = "cn-hangzhou-i"
    local_storage_instance_type = "null"
  }
  vswitches {
    vswitch_id = alicloud_vswitch.default106DkE.id
    zone_id    = "cn-hangzhou-i"
  }
  backend_node_groups {
    cu                          = "8"
    storage_size                = "100"
    resident_node_number        = "3"
    disk_number                 = "1"
    storage_performance_level   = "pl1"
    spec_type                   = "standard"
    zone_id                     = "cn-hangzhou-i"
    local_storage_instance_type = "null"
  }
  cluster_zone_id         = "cn-hangzhou-i"
  duration                = "1"
  pay_type                = "postPaid"
  vpc_id                  = alicloud_vpc.defaultB21JUD.id
  version                 = "3.3"
  run_mode                = "shared_data"
  package_type            = "official"
  admin_password          = "1qaz@QAZ"
  oss_accessing_role_name = "AliyunEMRStarRocksAccessingOSSRole"
  pricing_cycle           = "Month"
  kms_key_id              = "123"
  promotion_option_no     = "123"
  encrypted               = false
  observer_node_groups {
    cu                          = "8"
    storage_size                = "100"
    storage_performance_level   = "pl1"
    disk_number                 = "1"
    resident_node_number        = "1"
    spec_type                   = "standard"
    local_storage_instance_type = "null"
    zone_id                     = "cn-hangzhou-h"
  }
}
variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_vpc" "defaultq6pcFe" {
  cidr_block = "172.16.0.0/12"
  vpc_name   = "example-vpc-487"
}

resource "alicloud_vswitch" "defaultujlpyG" {
  vpc_id       = alicloud_vpc.defaultq6pcFe.id
  zone_id      = "cn-hangzhou-i"
  cidr_block   = "172.16.0.0/24"
  vswitch_name = "sr-example-ng"
}

resource "alicloud_star_rocks_instance" "defaultvjnpM0" {
  cluster_zone_id = "cn-hangzhou-i"
  encrypted       = false
  auto_renew      = false
  pay_type        = "postPaid"
  frontend_node_groups {
    cu                        = "8"
    storage_size              = "100"
    storage_performance_level = "pl1"
    disk_number               = "1"
    zone_id                   = "cn-hangzhou-i"
    spec_type                 = "standard"
    resident_node_number      = "1"
  }
  instance_name = "t1"
  vswitches {
    zone_id    = "cn-hangzhou-i"
    vswitch_id = alicloud_vswitch.defaultujlpyG.id
  }
  vpc_id                  = alicloud_vpc.defaultq6pcFe.id
  version                 = "3.3"
  run_mode                = "shared_data"
  package_type            = "official"
  oss_accessing_role_name = "AliyunEMRStarRocksAccessingOSSRolecn"
  admin_password          = "1qaz@QAZ"
  backend_node_groups {
    cu                        = "8"
    storage_size              = "200"
    zone_id                   = "cn-hangzhou-i"
    spec_type                 = "standard"
    resident_node_number      = "3"
    disk_number               = "1"
    storage_performance_level = "pl1"
  }
}


resource "alicloud_star_rocks_node_group" "default" {
  description                 = "example_desc"
  node_group_name             = "ng_676"
  instance_id                 = alicloud_star_rocks_instance.defaultvjnpM0.id
  spec_type                   = "standard"
  storage_performance_level   = "pl1"
  pricing_cycle               = "1"
  auto_renew                  = false
  storage_size                = "200"
  duration                    = "1"
  pay_type                    = "postPaid"
  cu                          = "8"
  disk_number                 = "1"
  resident_node_number        = "1"
  local_storage_instance_type = "non_local_storage"
  promotion_option_no         = "blank"
}
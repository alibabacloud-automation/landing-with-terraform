provider "alicloud" {
  region = "cn-beijing"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "tf_test_foo"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id     = alicloud_vpc.vpc.id
  cidr_block = "172.16.0.0/21"
  zone_id    = data.alicloud_zones.default.zones[0].id
}

resource "alicloud_security_group" "default" {
  name   = "default"
  vpc_id = alicloud_vpc.vpc.id
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

data "alicloud_instance_types" "default" {
  availability_zone = data.alicloud_zones.default.zones[0].id
  cpu_core_count    = 1
  memory_size       = 2
}

data "alicloud_images" "default" {
  name_regex  = "^ubuntu_[0-9]+_[0-9]+_x64*"
  most_recent = true
  owners      = "system"
}

module "tf-instances" {
  source                      = "alibaba/ecs-instance/alicloud"
  region                      = "cn-beijing"
  number_of_instances         = 3
  vswitch_id                  = alicloud_vswitch.vsw.id
  group_ids                   = [alicloud_security_group.default.id]
  private_ips                 = ["172.16.0.10", "172.16.0.11", "172.16.0.12"]
  image_ids                   = [data.alicloud_images.default.images[0].id]
  instance_type               = data.alicloud_instance_types.default.instance_types[0].id
  internet_max_bandwidth_out  = 10
  associate_public_ip_address = true
  instance_name               = "my_module_instances_"
  host_name                   = "sample"
  internet_charge_type        = "PayByTraffic"
  password                    = "User@123"
  system_disk_category        = "cloud_ssd"
  data_disks = [
    {
      category = "cloud_ssd"
      name     = "my_module_disk"
      size     = "50"
    }
  ]
}
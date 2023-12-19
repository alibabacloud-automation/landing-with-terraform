provider "alicloud" {
  region = "cn-beijing"
}

resource "alicloud_vpc" "vpc" {
  name       = "tf_test_foo"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id            = alicloud_vpc.vpc.id
  cidr_block        = "172.16.0.0/21"
  availability_zone = "cn-beijing-b"
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

module "tf-instances" {
  source                      = "alibaba/ecs-instance/alicloud"
  region                      = "cn-beijing"
  number_of_instances         = 3
  vswitch_id                  = alicloud_vswitch.vsw.id
  group_ids                   = [alicloud_security_group.default.id]
  private_ips                 = ["172.16.0.10", "172.16.0.11", "172.16.0.12"]
  image_ids                   = ["ubuntu_18_04_64_20G_alibase_20190624.vhd"]
  instance_type               = "ecs.n2.small"
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

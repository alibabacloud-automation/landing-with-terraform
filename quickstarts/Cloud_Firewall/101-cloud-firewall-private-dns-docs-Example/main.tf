variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_account" "current" {
}

resource "alicloud_vpc" "vpc" {
  cidr_block = "172.16.0.0/12"
  vpc_name   = "yqc-example-vpc"
}

resource "alicloud_vswitch" "vpcvsw1" {
  vpc_id     = alicloud_vpc.vpc.id
  zone_id    = "cn-hangzhou-i"
  cidr_block = "172.16.3.0/24"
}

resource "alicloud_vswitch" "vpcvsw2" {
  vpc_id     = alicloud_vpc.vpc.id
  zone_id    = "cn-hangzhou-j"
  cidr_block = "172.16.4.0/24"
}


resource "alicloud_cloud_firewall_private_dns" "default" {
  region_no            = "cn-hangzhou"
  access_instance_name = var.name
  port                 = "53"
  primary_vswitch_id   = alicloud_vswitch.vpcvsw1.id
  standby_dns          = "4.4.4.4"
  primary_dns          = "8.8.8.8"
  vpc_id               = alicloud_vpc.vpc.id
  private_dns_type     = "Custom"
  firewall_type        = ["internet"]
  ip_protocol          = "UDP"
  standby_vswitch_id   = alicloud_vswitch.vpcvsw2.id
  domain_name_list     = ["www.aliyun.com"]
  primary_vswitch_ip   = "172.16.3.1"
  standby_vswitch_ip   = "172.16.4.1"
  member_uid           = data.alicloud_account.current.id
}
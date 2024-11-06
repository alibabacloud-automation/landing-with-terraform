variable "region" {
  default = "cn-qingdao"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
  available_disk_category     = "cloud_ssd"
}

variable "vpc_cidr_block" {
  default = "172.16.0.0/16"
}

variable "vsw_cidr_block" {
  default = "172.16.0.0/24"
}

variable "node_spec" {
  default = "elasticsearch.sn2ne.large"
}
provider "alicloud" {
  region = var.region
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc-test_${random_integer.default.result}"
  cidr_block = var.vpc_cidr_block
}

resource "alicloud_security_group" "group" {
  name   = "test_${random_integer.default.result}"
  vpc_id = alicloud_vpc.vpc.id
}

resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.vsw_cidr_block
  zone_id      = data.alicloud_zones.default.zones[0].id
  vswitch_name = "vswitch-test-${random_integer.default.result}"
}

resource "alicloud_elasticsearch_instance" "instance" {
  description                      = "test_Instance"
  instance_charge_type             = "PostPaid"
  data_node_amount                 = "2"
  data_node_spec                   = var.node_spec
  data_node_disk_size              = "20"
  data_node_disk_type              = "cloud_ssd"
  vswitch_id                       = alicloud_vswitch.vswitch.id
  password                         = "es_password_01"
  version                          = "6.7_with_X-Pack"
  master_node_spec                 = var.node_spec
  zone_count                       = "1"
  master_node_disk_type            = "cloud_ssd"
  kibana_node_spec                 = var.node_spec
  data_node_disk_performance_level = "PL1"
  tags = {
    Created = "TF",
    For     = "example",
  }
}
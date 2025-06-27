variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

variable "cluster_id" {
  default = "c18c40b2b336840e2b2bbf8ab291758e2"
}

variable "deploymentsetid" {
  default = "ds-2ze78ef5kyj9eveue92m"
}

variable "vswtich-id" {
  default = "example_vswitch"
}

variable "vpc_name" {
  default = "beijing111"
}

variable "example_region_id" {
  default = "cn-beijing"
}

variable "description" {
  default = "ran_1-08_rccreatenodepool_api"
}

variable "example_zone_id" {
  default = "cn-beijing-h"
}

variable "securitygroup_name" {
  default = "rds_custom_init_sg_cn_beijing"
}

data "alicloud_resource_manager_resource_groups" "default" {}

resource "alicloud_vpc" "vpcId" {
  vpc_name = var.vpc_name
}

resource "alicloud_vswitch" "vSwitchId" {
  vpc_id       = alicloud_vpc.vpcId.id
  zone_id      = var.example_zone_id
  vswitch_name = var.vswtich-id
  cidr_block   = "172.16.5.0/24"
}

resource "alicloud_security_group" "securityGroupId" {
  vpc_id              = alicloud_vpc.vpcId.id
  security_group_name = var.securitygroup_name
}

resource "alicloud_ecs_deployment_set" "deploymentSet" {
}

resource "alicloud_ecs_key_pair" "KeyPairName" {
  key_pair_name = alicloud_vswitch.vSwitchId.id
}


resource "alicloud_rds_custom" "default" {
  amount        = "1"
  auto_renew    = false
  period        = "1"
  auto_pay      = true
  instance_type = "mysql.x2.xlarge.6cm"
  data_disk {
    category          = "cloud_essd"
    size              = "50"
    performance_level = "PL1"
  }
  status                        = "Running"
  security_group_ids            = ["${alicloud_security_group.securityGroupId.id}"]
  io_optimized                  = "optimized"
  description                   = var.description
  key_pair_name                 = alicloud_ecs_key_pair.KeyPairName.id
  zone_id                       = var.example_zone_id
  instance_charge_type          = "Prepaid"
  internet_max_bandwidth_out    = "0"
  image_id                      = "aliyun_2_1903_x64_20G_alibase_20240628.vhd"
  security_enhancement_strategy = "Active"
  period_unit                   = "Month"
  password                      = "jingyiTEST@123"
  system_disk {
    size     = "40"
    category = "cloud_essd"
  }
  host_name         = "1743386110"
  create_mode       = "0"
  spot_strategy     = "NoSpot"
  vswitch_id        = alicloud_vswitch.vSwitchId.id
  support_case      = "eni"
  deployment_set_id = var.deploymentsetid
  dry_run           = false
}
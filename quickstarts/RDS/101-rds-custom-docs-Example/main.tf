variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-chengdu"
}

variable "example_zone_id" {
  default = "cn-chengdu-b"
}

data "alicloud_resource_manager_resource_groups" "default" {}

data "alicloud_vpcs" "default" {
}
data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = var.example_zone_id
}

resource "alicloud_vpc" "vpcId" {
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "vSwitchId" {
  vpc_id       = alicloud_vpc.vpcId.id
  cidr_block   = "172.16.5.0/24"
  zone_id      = var.example_zone_id
  vswitch_name = format("%s1", var.name)
}

resource "alicloud_security_group" "securityGroupId" {
  vpc_id = alicloud_vpc.vpcId.id
}

resource "alicloud_ecs_deployment_set" "deploymentSet" {
  domain      = "Default"
  granularity = "Host"
  strategy    = "Availability"
}

resource "alicloud_ecs_key_pair" "KeyPairName" {
  key_pair_name = format("%s4", var.name)
}

resource "alicloud_rds_custom" "default" {
  data_disk {
    category          = "cloud_essd"
    size              = "50"
    performance_level = "PL1"
  }

  host_name         = "1731641300"
  create_mode       = "0"
  description       = var.name
  instance_type     = "mysql.x2.xlarge.6cm"
  password          = "example@12356"
  amount            = "1"
  io_optimized      = "optimized"
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.ids.0
  deployment_set_id = alicloud_ecs_deployment_set.deploymentSet.id
  status            = "Running"
  system_disk {
    category = "cloud_essd"
    size     = "40"
  }

  auto_pay                   = "true"
  internet_max_bandwidth_out = "0"
  internet_charge_type       = "PayByTraffic"
  security_group_ids = [
    alicloud_security_group.securityGroupId.id
  ]
  instance_charge_type          = "Prepaid"
  vswitch_id                    = alicloud_vswitch.vSwitchId.id
  key_pair_name                 = alicloud_ecs_key_pair.KeyPairName.key_pair_name
  zone_id                       = var.example_zone_id
  auto_renew                    = "false"
  period                        = "1"
  image_id                      = "aliyun_2_1903_x64_20G_alibase_20240628.vhd"
  security_enhancement_strategy = "Active"
  period_unit                   = "Month"
}
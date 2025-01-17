variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

resource "alicloud_vpc" "default5Bia4h" {
  description = var.name
  vpc_name    = var.name
  cidr_block  = "10.0.0.0/8"
}

resource "alicloud_vswitch" "defaultss7s7F" {
  description  = var.name
  vpc_id       = alicloud_vpc.default5Bia4h.id
  zone_id      = "cn-beijing-g"
  vswitch_name = format("%s1", var.name)
  cidr_block   = "10.0.0.0/24"
}

resource "alicloud_data_works_dw_resource_group" "defaultVJvKvl" {
  payment_duration_unit = "Month"
  payment_type          = "PostPaid"
  specification         = "500"
  default_vswitch_id    = alicloud_vswitch.defaultss7s7F.id
  remark                = var.name
  resource_group_name   = "network_openapi_example01"
  default_vpc_id        = alicloud_vpc.default5Bia4h.id
}

resource "alicloud_vpc" "defaulte4zhaL" {
  description = var.name
  vpc_name    = format("%s3", var.name)
  cidr_block  = "172.16.0.0/12"
}

resource "alicloud_vswitch" "default675v38" {
  description  = var.name
  vpc_id       = alicloud_vpc.defaulte4zhaL.id
  zone_id      = "cn-beijing-g"
  vswitch_name = format("%s4", var.name)
  cidr_block   = "172.16.0.0/24"
}


resource "alicloud_data_works_network" "default" {
  vpc_id               = alicloud_vpc.defaulte4zhaL.id
  vswitch_id           = alicloud_vswitch.default675v38.id
  dw_resource_group_id = alicloud_data_works_dw_resource_group.defaultVJvKvl.id
}
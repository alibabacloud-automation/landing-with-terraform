variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

resource "alicloud_data_works_project" "defaultZImuCO" {
  description  = "default_pj002"
  project_name = var.name
  display_name = "default_pj002"
}

resource "alicloud_vpc" "defaulte4zhaL" {
  description = "default_resgv2_vpc001"
  vpc_name    = format("%s1", var.name)
  cidr_block  = "172.16.0.0/12"
}

resource "alicloud_vswitch" "default675v38" {
  description  = "default_resg_vsw001"
  vpc_id       = alicloud_vpc.defaulte4zhaL.id
  zone_id      = "cn-beijing-g"
  vswitch_name = format("%s2", var.name)
  cidr_block   = "172.16.0.0/24"
}


resource "alicloud_data_works_dw_resource_group" "default" {
  payment_type          = "PostPaid"
  default_vpc_id        = alicloud_vpc.defaulte4zhaL.id
  remark                = "openapi_example"
  resource_group_name   = "openapi_pop2_example_resg00002"
  default_vswitch_id    = alicloud_vswitch.default675v38.id
  payment_duration_unit = "Month"
  specification         = "500"
  payment_duration      = "1"
}
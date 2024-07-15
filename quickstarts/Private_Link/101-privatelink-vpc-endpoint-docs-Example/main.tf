variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "ap-southeast-5"
}

data "alicloud_resource_manager_resource_groups" "default" {}

resource "alicloud_vpc" "defaultbFzA4a" {
  description = "example-terraform"
  cidr_block  = "172.16.0.0/12"
  vpc_name    = var.name
}

resource "alicloud_security_group" "default1FTFrP" {
  name   = var.name
  vpc_id = alicloud_vpc.defaultbFzA4a.id
}

resource "alicloud_security_group" "defaultjljY5S" {
  name   = var.name
  vpc_id = alicloud_vpc.defaultbFzA4a.id
}

resource "alicloud_privatelink_vpc_endpoint" "default" {
  endpoint_description          = var.name
  vpc_endpoint_name             = var.name
  resource_group_id             = data.alicloud_resource_manager_resource_groups.default.ids.0
  endpoint_type                 = "Interface"
  vpc_id                        = alicloud_vpc.defaultbFzA4a.id
  service_name                  = "com.aliyuncs.privatelink.ap-southeast-5.oss"
  dry_run                       = "false"
  zone_private_ip_address_count = "1"
  policy_document               = jsonencode({ "Version" : "1", "Statement" : [{ "Effect" : "Allow", "Action" : ["*"], "Resource" : ["*"], "Principal" : "*" }] })
  security_group_ids = [
    "${alicloud_security_group.default1FTFrP.id}"
  ]
  service_id        = "epsrv-k1apjysze8u1l9t6uyg9"
  protected_enabled = "false"
}
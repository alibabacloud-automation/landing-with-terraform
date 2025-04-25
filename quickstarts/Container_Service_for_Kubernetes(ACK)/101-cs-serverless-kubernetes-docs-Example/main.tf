variable "name" {
  default = "ask-example-pro"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.2.0.0/21"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "10.2.1.0/24"
  zone_id      = data.alicloud_zones.default.zones[0].id
}

resource "alicloud_cs_serverless_kubernetes" "serverless" {
  name_prefix                    = var.name
  cluster_spec                   = "ack.pro.small"
  vpc_id                         = alicloud_vpc.default.id
  vswitch_ids                    = [alicloud_vswitch.default.id]
  new_nat_gateway                = true
  endpoint_public_access_enabled = true
  deletion_protection            = false
  time_zone                      = "Asia/Shanghai"
  service_cidr                   = "172.21.0.0/20"

  # tags
  tags = {
    "k-aa" = "v-aa"
    "k-bb" = "v-bb"
  }
}
provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tf-example"
}

data "alicloud_zones" "example" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "example" {
  vpc_name   = "terraform-example"
  cidr_block = "172.17.3.0/24"
}

resource "alicloud_vswitch" "example" {
  vswitch_name = "terraform-example"
  cidr_block   = "172.17.3.0/24"
  vpc_id       = alicloud_vpc.example.id
  zone_id      = data.alicloud_zones.example.zones.0.id
}

resource "alicloud_mse_cluster" "default" {
  connection_type       = "slb"
  net_type              = "privatenet"
  vswitch_id            = alicloud_vswitch.example.id
  cluster_specification = "MSE_SC_1_2_60_c"
  cluster_version       = "NACOS_2_0_0"
  instance_count        = "1"
  pub_network_flow      = "1"
  cluster_alias_name    = var.name
  mse_version           = "mse_dev"
  cluster_type          = "Nacos-Ans"
}

resource "alicloud_mse_engine_namespace" "example" {
  cluster_id          = alicloud_mse_cluster.default.id
  namespace_show_name = var.name
  namespace_id        = var.name
}
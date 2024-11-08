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

resource "alicloud_mse_cluster" "example" {
  connection_type       = "slb"
  net_type              = "privatenet"
  vswitch_id            = alicloud_vswitch.example.id
  cluster_specification = "MSE_SC_1_2_60_c"
  cluster_version       = "NACOS_2_0_0"
  instance_count        = "3"
  pub_network_flow      = "1"
  cluster_alias_name    = "example"
  mse_version           = "mse_pro"
  cluster_type          = "Nacos-Ans"
}

resource "alicloud_mse_engine_namespace" "example" {
  instance_id         = alicloud_mse_cluster.example.id
  namespace_show_name = "example"
  namespace_id        = "example"
}

resource "alicloud_mse_nacos_config" "example" {
  instance_id  = alicloud_mse_cluster.example.id
  data_id      = "example"
  group        = "example"
  namespace_id = alicloud_mse_engine_namespace.example.namespace_id
  content      = "example"
  type         = "text"
  tags         = "example"
  app_name     = "example"
  desc         = "example"
}
variable "db_cluster_nodes_configs" {
  description = "The advanced configuration for all nodes in the cluster except for the RW node, including db_node_class, hot_replica_mode, and imci_switch properties."
  type = map(object({
    db_node_class    = string
    db_node_role     = optional(string, null)
    hot_replica_mode = optional(string, null)
    imci_switch      = optional(string, null)
  }))
  default = {
    db_node_1 = {
      db_node_class = "polar.mysql.x4.medium.c"
      db_node_role  = "Writer"
    }
    db_node_2 = {
      db_node_class = "polar.mysql.x4.medium.c"
      db_node_role  = "Reader"
    }
  }
}

resource "alicloud_ens_network" "default" {
  network_name = "terraform-example"

  description   = "LoadBalancerNetworkDescription_test"
  cidr_block    = "192.168.2.0/24"
  ens_region_id = "tr-Istanbul-1"
}

resource "alicloud_ens_vswitch" "default" {
  description  = "LoadBalancerVSwitchDescription_test"
  cidr_block   = "192.168.2.0/24"
  vswitch_name = "terraform-example"

  ens_region_id = "tr-Istanbul-1"
  network_id    = alicloud_ens_network.default.id
}

resource "alicloud_polardb_zonal_db_cluster" "default" {
  db_node_class = "polar.mysql.x4.medium.c"
  description   = "terraform-example"
  ens_region_id = "tr-Istanbul-1"
  vpc_id        = alicloud_ens_network.default.id
  vswitch_id    = alicloud_ens_vswitch.default.id
  db_cluster_nodes_configs = {
    for node, config in var.db_cluster_nodes_configs : node => jsonencode({ for k, v in config : k => v if v != null })
  }
}
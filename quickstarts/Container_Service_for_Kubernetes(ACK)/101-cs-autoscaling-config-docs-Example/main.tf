variable "name" {
  default = "terraform-example"
}
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}
data "alicloud_instance_types" "default" {
  availability_zone    = data.alicloud_zones.default.zones.0.id
  cpu_core_count       = 4
  memory_size          = 8
  kubernetes_node_role = "Worker"
  system_disk_category = "cloud_essd"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}
resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "10.4.0.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_cs_managed_kubernetes" "default" {
  name_prefix          = var.name
  cluster_spec         = "ack.pro.small"
  worker_vswitch_ids   = [alicloud_vswitch.default.id]
  new_nat_gateway      = true
  pod_cidr             = cidrsubnet("10.0.0.0/8", 8, 36)
  service_cidr         = cidrsubnet("172.16.0.0/16", 4, 7)
  slb_internet_enabled = true
}

resource "alicloud_cs_kubernetes_node_pool" "default" {
  count                = 3
  node_pool_name       = format("%s-%d", var.name, count.index)
  cluster_id           = alicloud_cs_managed_kubernetes.default.id
  vswitch_ids          = [alicloud_vswitch.default.id]
  instance_types       = [data.alicloud_instance_types.default.instance_types.0.id]
  system_disk_category = "cloud_essd"
  system_disk_size     = 40
  image_type           = "AliyunLinux3"
  scaling_config {
    enable   = true
    min_size = 0
    max_size = 10
  }
}

resource "alicloud_cs_autoscaling_config" "default" {
  cluster_id = alicloud_cs_managed_kubernetes.default.id
  // configure auto scaling
  cool_down_duration            = "10m"
  unneeded_duration             = "10m"
  utilization_threshold         = "0.5"
  gpu_utilization_threshold     = "0.5"
  scan_interval                 = "30s"
  scale_down_enabled            = true
  expander                      = "priority"
  skip_nodes_with_system_pods   = true
  skip_nodes_with_local_storage = false
  daemonset_eviction_for_nodes  = false
  max_graceful_termination_sec  = 14400
  min_replica_count             = 0
  recycle_node_deletion_enabled = false
  scale_up_from_zero            = true
  scaler_type                   = "cluster-autoscaler"
  priorities = {
    10 = join(",", [
      alicloud_cs_kubernetes_node_pool.default[0].scaling_group_id,
      alicloud_cs_kubernetes_node_pool.default[1].scaling_group_id,
    ])
    20 = alicloud_cs_kubernetes_node_pool.default[2].scaling_group_id
  }
}
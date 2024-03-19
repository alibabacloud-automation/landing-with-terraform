resource "random_integer" "default" {
  max = 99999
  min = 10000
}

variable "name" {
  default = "terraform-example"
}

data "alicloud_enhanced_nat_available_zones" "enhanced" {
}

data "alicloud_instance_types" "default" {
  availability_zone    = data.alicloud_enhanced_nat_available_zones.enhanced.zones.0.zone_id
  cpu_core_count       = 4
  memory_size          = 8
  kubernetes_node_role = "Worker"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}
resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "10.4.0.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_enhanced_nat_available_zones.enhanced.zones.0.zone_id
}

resource "alicloud_cs_managed_kubernetes" "default" {
  name_prefix          = "terraform-example-${random_integer.default.result}"
  cluster_spec         = "ack.pro.small"
  worker_vswitch_ids   = [alicloud_vswitch.default.id]
  new_nat_gateway      = true
  pod_cidr             = cidrsubnet("10.0.0.0/8", 8, 36)
  service_cidr         = cidrsubnet("172.16.0.0/16", 4, 7)
  slb_internet_enabled = true
  enable_rrsa          = true
}

resource "alicloud_key_pair" "default" {
  key_pair_name = "terraform-example-${random_integer.default.result}"
}

resource "alicloud_cs_kubernetes_node_pool" "default" {
  name                 = var.name
  cluster_id           = alicloud_cs_managed_kubernetes.default.id
  vswitch_ids          = [alicloud_vswitch.default.id]
  instance_types       = ["ecs.c7.xlarge"]
  system_disk_category = "cloud_efficiency"
  system_disk_size     = 40
  key_name             = alicloud_key_pair.default.key_name
  // define with multi-labels by defining with labels blocks
  labels {
    key   = "test1"
    value = "nodepool"
  }
  labels {
    key   = "test2"
    value = "nodepool"
  }
  // define with multi-taints by defining with taints blocks
  taints {
    key    = "tf"
    effect = "NoSchedule"
    value  = "example"
  }
  taints {
    key    = "tf2"
    effect = "NoSchedule"
    value  = "example2"
  }
}

#The parameter `node_count` is deprecated from version 1.158.0. Please use the new parameter `desired_size` instead, you can update it as follows.
resource "alicloud_cs_kubernetes_node_pool" "desired_size" {
  name                 = "desired_size"
  cluster_id           = alicloud_cs_managed_kubernetes.default.id
  vswitch_ids          = [alicloud_vswitch.default.id]
  instance_types       = [data.alicloud_instance_types.default.instance_types.0.id]
  system_disk_category = "cloud_efficiency"
  system_disk_size     = 40
  key_name             = alicloud_key_pair.default.key_name
  desired_size         = 2
}

#Create a managed node pool. If you need to enable maintenance window, you need to set the maintenance window in `alicloud_cs_managed_kubernetes`.
resource "alicloud_cs_kubernetes_node_pool" "maintenance" {
  name                 = "maintenance"
  cluster_id           = alicloud_cs_managed_kubernetes.default.id
  vswitch_ids          = [alicloud_vswitch.default.id]
  instance_types       = [data.alicloud_instance_types.default.instance_types.0.id]
  system_disk_category = "cloud_efficiency"
  system_disk_size     = 40

  # only key_name is supported in the management node pool
  key_name = alicloud_key_pair.default.key_name

  # you need to specify the number of nodes in the node pool, which can be zero
  desired_size = 1

  # management node pool configuration.
  management {
    enable      = true
    auto_repair = true
    auto_repair_policy {
      restart_node = true
    }
    auto_upgrade = true
    auto_upgrade_policy {
      auto_upgrade_kubelet = true
    }
    auto_vul_fix = true
    auto_vul_fix_policy {
      vul_level    = "asap"
      restart_node = true
    }
    max_unavailable = 1
  }

  # Enable with automatic scaling node pool configuration.
  # With auto-scaling is enabled, the nodes in the node pool will be labeled with `k8s.aliyun.com=true` to prevent system pods such as coredns, metrics-servers from being scheduled to elastic nodes, and to prevent node shrinkage from causing business abnormalities.
  #  scaling_config {
  #    min_size = 1
  #    max_size = 10
  #    type     = "cpu"
  #  }
}

#Create a node pool with spot instance.
resource "alicloud_cs_kubernetes_node_pool" "spot_instance" {
  name                 = "spot_instance"
  cluster_id           = alicloud_cs_managed_kubernetes.default.id
  vswitch_ids          = [alicloud_vswitch.default.id]
  instance_types       = [data.alicloud_instance_types.default.instance_types.0.id, data.alicloud_instance_types.default.instance_types.1.id]
  system_disk_category = "cloud_efficiency"
  system_disk_size     = 40
  key_name             = alicloud_key_pair.default.key_name

  # you need to specify the number of nodes in the node pool, which can be 0
  desired_size = 1

  # spot config
  spot_strategy = "SpotWithPriceLimit"
  spot_price_limit {
    instance_type = data.alicloud_instance_types.default.instance_types.0.id
    # Different instance types have different price caps
    price_limit = "0.70"
  }
  // define with multi-spot_price_limit by defining with spot_price_limit blocks
  spot_price_limit {
    instance_type = data.alicloud_instance_types.default.instance_types.1.id
    price_limit   = "0.72"
  }
}


#Use Spot instances to create a node pool with auto-scaling enabled
resource "alicloud_cs_kubernetes_node_pool" "spot_auto_scaling" {
  name                 = "spot_auto_scaling"
  cluster_id           = alicloud_cs_managed_kubernetes.default.id
  vswitch_ids          = [alicloud_vswitch.default.id]
  instance_types       = [data.alicloud_instance_types.default.instance_types.0.id]
  system_disk_category = "cloud_efficiency"
  system_disk_size     = 40
  key_name             = alicloud_key_pair.default.key_name

  # automatic scaling node pool configuration.
  scaling_config {
    min_size = 1
    max_size = 10
    type     = "spot"
  }
  # spot price config
  spot_strategy = "SpotWithPriceLimit"
  spot_price_limit {
    instance_type = data.alicloud_instance_types.default.instance_types.0.id
    price_limit   = "0.70"
  }
}

#Create a `PrePaid` node pool.
resource "alicloud_cs_kubernetes_node_pool" "prepaid_node" {
  name                 = "prepaid_node"
  cluster_id           = alicloud_cs_managed_kubernetes.default.id
  vswitch_ids          = [alicloud_vswitch.default.id]
  instance_types       = [data.alicloud_instance_types.default.instance_types.0.id]
  system_disk_category = "cloud_efficiency"
  system_disk_size     = 40
  key_name             = alicloud_key_pair.default.key_name
  # use PrePaid
  instance_charge_type = "PrePaid"
  period               = 1
  period_unit          = "Month"
  auto_renew           = true
  auto_renew_period    = 1

  # open cloud monitor
  install_cloud_monitor = true
}

#Create a node pool with customized kubelet parameters
resource "alicloud_cs_kubernetes_node_pool" "customized_kubelet" {
  name                 = "customized_kubelet"
  cluster_id           = alicloud_cs_managed_kubernetes.default.id
  vswitch_ids          = [alicloud_vswitch.default.id]
  instance_types       = [data.alicloud_instance_types.default.instance_types.0.id]
  system_disk_category = "cloud_efficiency"
  system_disk_size     = 40
  instance_charge_type = "PostPaid"
  desired_size         = 0

  # kubelet configuration parameters
  kubelet_configuration {
    registry_pull_qps     = 10
    registry_burst        = 5
    event_record_qps      = 10
    event_burst           = 5
    serialize_image_pulls = true
    eviction_hard = {
      "memory.available"  = "1024Mi"
      "nodefs.available"  = "10%"
      "nodefs.inodesFree" = "5%"
      "imagefs.available" = "10%"
    }
    system_reserved = {
      "cpu"               = "1"
      "memory"            = "1Gi"
      "ephemeral-storage" = "10Gi"
    }
    kube_reserved = {
      "cpu"    = "500m"
      "memory" = "1Gi"
    }
    container_log_max_size  = "200Mi"
    container_log_max_files = 3
    max_pods                = 100
    read_only_port          = 0
    allowed_unsafe_sysctls  = ["net.ipv4.route.min_pmtu"]
  }

  # rolling policy: works when updating
  rolling_policy {
    max_parallelism = 1
  }
}
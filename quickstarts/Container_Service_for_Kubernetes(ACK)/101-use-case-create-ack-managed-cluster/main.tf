provider "alicloud" {
  region = var.region_id
}

variable "region_id" {
  type    = string
  default = "cn-shenzhen"
}

# 指定虚拟交换机（vSwitches）的可用区。
variable "availability_zone" {  
  description = "The availability zones of vswitches."
  default     = ["cn-shenzhen-c", "cn-shenzhen-e", "cn-shenzhen-f"]
} 

 # 指定交换机ID（vSwitch IDs）的列表。
variable "node_vswitch_ids" {
  description = "List of existing node vswitch ids for terway."
  type        = list(string)
  default     = []
}

# 当没有提供node_vswitch_ids时，这个变量定义了用于创建新vSwitches的CIDR地址块列表。
variable "node_vswitch_cidrs" { 
  description = "List of cidr blocks used to create several new vswitches when 'node_vswitch_ids' is not specified."
  type        = list(string)
  default     = ["172.16.0.0/23", "172.16.2.0/23", "172.16.4.0/23"]
}

# 指定网络组件Terway配置。如果为空，默认会根据terway_vswitch_cidrs的创建新的terway vSwitch。
variable "terway_vswitch_ids" { 
  description = "List of existing pod vswitch ids for terway."
  type        = list(string)
  default     = []
}

# 当没有指定terway_vswitch_ids时，用于创建Terway使用的vSwitch的CIDR地址块。
variable "terway_vswitch_cidrs" {  
  description = "List of cidr blocks used to create several new vswitches when 'terway_vswitch_ids' is not specified."
  type        = list(string)
  default     = ["172.16.208.0/20", "172.16.224.0/20", "172.16.240.0/20"]
}

 # 定义了用于启动工作节点的ECS实例类型。
variable "worker_instance_types" {
  description = "The ecs instance types used to launch worker nodes."
  default     = ["ecs.g6.2xlarge", "ecs.g6.xlarge"]
}

# 设置工作阶段的密码
variable "password" {
  description = "The password of ECS instance."
  default     = "Test123456"
}

 # 指定ACK集群安装的组件。包括Terway（网络组件）、csi-plugin（存储组件）、csi-provisioner（存储组件）、logtail-ds（日志组件）、Nginx Ingress Controller、ack-arms-prometheus（监控组件）以及ack-node-problem-detector（节点诊断组件）。
variable "cluster_addons" {   
  type = list(object({
    name   = string
    config = string
  }))

  default = [
    {
      "name"   = "terway-eniip",
      "config" = "",
    },
    {
      "name"   = "logtail-ds",
      "config" = "{\"IngressDashboardEnabled\":\"true\"}",
    },
    {
      "name"   = "nginx-ingress-controller",
      "config" = "{\"IngressSlbNetworkType\":\"internet\"}",
    },
    {
      "name"   = "arms-prometheus",
      "config" = "",
    },
    {
      "name"   = "ack-node-problem-detector",
      "config" = "{\"sls_project_name\":\"\"}",
    },
    {
      "name"   = "csi-plugin",
      "config" = "",
    },
    {
      "name"   = "csi-provisioner",
      "config" = "",
    }
  ]
}

# 指定创建ACK托管集群名称的前缀。
variable "k8s_name_prefix" {   
  description = "The name prefix used to create managed kubernetes cluster."
  default     = "tf-ack-shenzhen"
}

# 默认资源名称。
locals {
  k8s_name_terway         = substr(join("-", [var.k8s_name_prefix, "terway"]), 0, 63)
  k8s_name_flannel        = substr(join("-", [var.k8s_name_prefix, "flannel"]), 0, 63)
  k8s_name_ask            = substr(join("-", [var.k8s_name_prefix, "ask"]), 0, 63)
  new_vpc_name            = "tf-vpc-172-16"
  new_vsw_name_azD        = "tf-vswitch-azD-172-16-0"
  new_vsw_name_azE        = "tf-vswitch-azE-172-16-2"
  new_vsw_name_azF        = "tf-vswitch-azF-172-16-4"
  nodepool_name           = "default-nodepool"
  managed_nodepool_name   = "managed-node-pool"
  autoscale_nodepool_name = "autoscale-node-pool"
  log_project_name        = "log-for-${local.k8s_name_terway}"
}

# 节点ECS实例配置。将查询满足CPU、Memory要求的ECS实例类型。
data "alicloud_instance_types" "default" {
  cpu_core_count       = 8
  memory_size          = 32
  availability_zone    = var.availability_zone[0]
  kubernetes_node_role = "Worker"
}

# 专有网络。
resource "alicloud_vpc" "default" {
  vpc_name   = local.new_vpc_name
  cidr_block = "172.16.0.0/12"
}

# Node交换机。
resource "alicloud_vswitch" "vswitches" {
  count      = length(var.node_vswitch_ids) > 0 ? 0 : length(var.node_vswitch_cidrs)
  vpc_id     = alicloud_vpc.default.id
  cidr_block = element(var.node_vswitch_cidrs, count.index)
  zone_id    = element(var.availability_zone, count.index)
}

# Pod交换机。
resource "alicloud_vswitch" "terway_vswitches" {
  count      = length(var.terway_vswitch_ids) > 0 ? 0 : length(var.terway_vswitch_cidrs)
  vpc_id     = alicloud_vpc.default.id
  cidr_block = element(var.terway_vswitch_cidrs, count.index)
  zone_id    = element(var.availability_zone, count.index)
}

# Kubernetes托管版。
resource "alicloud_cs_managed_kubernetes" "default" {
  name               = local.k8s_name_terway     # Kubernetes集群名称。
  cluster_spec       = "ack.pro.small"           # 创建Pro版集群。
  version            = "1.28.9-aliyun.1"
  worker_vswitch_ids = split(",", join(",", alicloud_vswitch.vswitches.*.id)) # 节点池所在的vSwitch。指定一个或多个vSwitch的ID，必须在availability_zone指定的区域中。
  pod_vswitch_ids    = split(",", join(",", alicloud_vswitch.terway_vswitches.*.id)) # Pod虚拟交换机。
  new_nat_gateway    = true               # 是否在创建Kubernetes集群时创建新的NAT网关。默认为true。
  service_cidr       = "10.11.0.0/16"     # Pod网络的CIDR块。当cluster_network_type设置为flannel，你必须设定该参数。它不能与VPC CIDR相同，并且不能与VPC中的Kubernetes集群使用的CIDR相同，也不能在创建后进行修改。集群中允许的最大主机数量：256。
  slb_internet_enabled = true             # 是否为API Server创建Internet负载均衡。默认为false。
  enable_rrsa        = true
  control_plane_log_components = ["apiserver", "kcm", "scheduler", "ccm"]  # 控制平面日志。

  dynamic "addons" {    # 组件管理。
    for_each = var.cluster_addons
    content {
      name   = lookup(addons.value, "name", var.cluster_addons)
      config = lookup(addons.value, "config", var.cluster_addons)
    }
  }
}

# 普通节点池。
resource "alicloud_cs_kubernetes_node_pool" "default" { 
  cluster_id = alicloud_cs_managed_kubernetes.default.id     # Kubernetes集群名称。
  node_pool_name = local.nodepool_name                       # 节点池名称。
  vswitch_ids = split(",", join(",", alicloud_vswitch.vswitches.*.id))  # 节点池所在的vSwitch。指定一个或多个vSwitch的ID，必须在availability_zone指定的区域中。
  instance_types       = var.worker_instance_types
  instance_charge_type = "PostPaid"
  runtime_name    = "containerd"
  runtime_version = "1.6.20"
  desired_size = 2                       # 节点池的期望节点数。
  password = var.password                # SSH登录集群节点的密码。
  install_cloud_monitor = true           # 是否为Kubernetes的节点安装云监控。
  system_disk_category = "cloud_efficiency"
  system_disk_size     = 100
  image_type = "AliyunLinux"

  data_disks {     # 节点数据盘配置。
    category = "cloud_essd"   # 节点数据盘种类。
    size = 120      # 节点数据盘大小。
  }
}

# 创建托管节点池。
resource "alicloud_cs_kubernetes_node_pool" "managed_node_pool" {      
  cluster_id = alicloud_cs_managed_kubernetes.default.id              # Kubernetes集群名称。
  node_pool_name = local.managed_nodepool_name                    # 节点池名称。
  vswitch_ids = split(",", join(",", alicloud_vswitch.vswitches.*.id))     # 节点池所在的vSwitch。指定一个或多个vSwitch的ID，必须在availability_zone指定的区域中。
  desired_size = 0         # 节点池的期望节点数。

  management {
    auto_repair     = true
    auto_upgrade    = true
    max_unavailable = 1
  }

  instance_types       = var.worker_instance_types
  instance_charge_type = "PostPaid"
  runtime_name    = "containerd"
  runtime_version = "1.6.20"
  password = var.password
  install_cloud_monitor = true
  system_disk_category = "cloud_efficiency"
  system_disk_size     = 100
  image_type = "AliyunLinux"

  data_disks {
    category = "cloud_essd"
    size = 120
  }
}

# 创建自动伸缩节点池，节点池最多可以扩展到 10 个节点，最少保持 1 个节点。
resource "alicloud_cs_kubernetes_node_pool" "autoscale_node_pool" {
  cluster_id = alicloud_cs_managed_kubernetes.default.id
  node_pool_name = local.autoscale_nodepool_name
  vswitch_ids = split(",", join(",", alicloud_vswitch.vswitches.*.id))

  scaling_config {
    min_size = 1
    max_size = 10
  }

  instance_types = var.worker_instance_types
  runtime_name    = "containerd"
  runtime_version = "1.6.20"
  password = var.password                # SSH登录集群节点的密码。
  install_cloud_monitor = true           # 是否为kubernetes的节点安装云监控。
  system_disk_category = "cloud_efficiency"
  system_disk_size     = 100
  image_type = "AliyunLinux3"

  data_disks {                           # 节点数据盘配置。
    category = "cloud_essd"              # 节点数据盘种类。
    size = 120                           # 节点数据盘大小。
  }
}
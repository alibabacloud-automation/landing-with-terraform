provider "alicloud" {
  region = var.region_id
}

variable "region_id" {
  default = "cn-hangzhou"
}

variable "k8s_name_edge" {
  type        = string
  description = "The name used to create edge kubernetes cluster."
  default     = "edge-example"
}

variable "new_vpc_name" {
  type        = string
  description = "The name used to create vpc."
  default     = "tf-vpc-172-16"
}

variable "new_vsw_name" {
  type        = string
  description = "The name used to create vSwitch."
  default     = "tf-vswitch-172-16-0"
}

variable "nodepool_name" {
  type        = string
  description = "The name used to create node pool."
  default     = "edge-nodepool-1"
}

variable "k8s_login_password" {
  type    = string
  default = "Test123456"
}

variable "k8s_version" {
  type        = string
  description = "Kubernetes version"
  default     = "1.28.9-aliyun.1"
}

variable "containerd_runtime_version" {
  type    = string
  default = "1.6.34"
}

variable "cluster_spec" {
  type        = string
  description = "The cluster specifications of kubernetes cluster,which can be empty. Valid values:ack.standard : Standard managed clusters; ack.pro.small : Professional managed clusters."
  default     = "ack.pro.small"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
  available_disk_category     = "cloud_efficiency"
}

data "alicloud_instance_types" "default" {
  availability_zone    = data.alicloud_zones.default.zones.0.id
  cpu_core_count       = 4
  memory_size          = 8
  kubernetes_node_role = "Worker"
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = var.new_vpc_name
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "vsw" {
  vswitch_name = var.new_vsw_name
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = cidrsubnet(alicloud_vpc.vpc.cidr_block, 8, 8)
  zone_id      = data.alicloud_zones.default.zones.0.id
}


resource "alicloud_cs_edge_kubernetes" "edge" {
  name                  = var.k8s_name_edge
  version               = var.k8s_version
  cluster_spec          = var.cluster_spec
  worker_vswitch_ids    = split(",", join(",", alicloud_vswitch.vsw.*.id))
  worker_instance_types = [data.alicloud_instance_types.default.instance_types.0.id]
  password              = var.k8s_login_password
  new_nat_gateway       = true
  pod_cidr              = "10.10.0.0/16"
  service_cidr          = "10.12.0.0/16"
  load_balancer_spec    = "slb.s2.small"
  worker_number         = 1
  node_cidr_mask        = 24

  # 运行时。
  runtime = {
    name    = "containerd"
    version = var.containerd_runtime_version
  }
}
# 节点池。
resource "alicloud_cs_kubernetes_node_pool" "nodepool" {
  # Kubernetes集群名称。
  cluster_id = alicloud_cs_edge_kubernetes.edge.id
  # 节点池名称。
  node_pool_name = var.nodepool_name
  # 新的Kubernetes集群将位于的vSwitch。指定一个或多个vSwitch的ID。它必须在availability_zone指定的区域中。
  vswitch_ids = split(",", join(",", alicloud_vswitch.vsw.*.id))

  # ECS实例类型和收费方式。
  instance_types       = [data.alicloud_instance_types.default.instance_types.0.id]
  instance_charge_type = "PostPaid"

  # 可选，自定义实例名称。
  # node_name_mode      = "customized,edge-shenzhen,ip,default"

  #容器运行时。
  runtime_name    = "containerd"
  runtime_version = var.containerd_runtime_version

  # 集群节点池的期望节点数。
  desired_size = 2
  # SSH登录集群节点的密码。
  password = var.k8s_login_password

  # 是否为Kubernetes的节点安装云监控。
  install_cloud_monitor = true

  # 节点的系统磁盘类别。其有效值为cloud_ssd和cloud_efficiency。默认为cloud_efficiency。
  system_disk_category = "cloud_efficiency"
  system_disk_size     = 100

  # 操作系统类型。
  image_type = "AliyunLinux"

  # 节点数据盘配置。
  data_disks {
    # 节点数据盘种类。
    category = "cloud_efficiency"
    # 节点数据盘大小。
    size = 120
  }
  lifecycle {
    ignore_changes = [
      labels
    ]
  }
}
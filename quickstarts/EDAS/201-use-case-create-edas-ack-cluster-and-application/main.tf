variable "region" {
  default = "cn-shanghai"
}

variable "vpc_cidr_block" {
  default = "172.16.0.0/22"
}

variable "vsw_cidr_block" {
  default = "172.16.0.0/24"
}

variable "service_cidr" {
  default = "172.21.0.0/20"
}

variable "pod_cidr" {
  default = "192.168.0.0/16"
}

variable "kubernetes_version" {
  # 替换为您所需创建的集群版本。
  default = "1.31.1-aliyun.1"
}

variable "jdk" {
  # 替换为您所需的JDK。
  default = "Open JDK 8"
}

variable "package_url" {
  # 替换为您的应用所在地址。
  default = "http://edas-bj.oss-cn-beijing.aliyuncs.com/prod/demo/SPRING_CLOUD_PROVIDER.jar"
}

variable "cluster_spec" {
  # 替换为您所需创建的集群规格。
  default = "ack.pro.small"
}

# options: ipvs|iptables
variable "proxy_mode" {
  description = "Proxy mode is option of kube-proxy."
  default     = "ipvs"
}

variable "system_disk_category" {
  default = "cloud_efficiency"
}

variable "instance_types" {
  default = "ecs.g5ne.xlarge"
}

provider "alicloud" {
  region = var.region
}

locals {
  region = var.region
}

# 查询可以创建交换机的可用区
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

# 随机数
resource "random_integer" "default" {
  min = 10000
  max = 99999
}

# 专有网络VPC
resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc-test_${random_integer.default.result}"
  cidr_block = var.vpc_cidr_block
}

# 交换机
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.vsw_cidr_block
  zone_id      = data.alicloud_zones.default.zones[0].id
  vswitch_name = "vswitch-test-${random_integer.default.result}"
}

# 创建kubernetes集群
resource "alicloud_cs_managed_kubernetes" "default" {
  name_prefix        = "tf-kubernetes-${random_integer.default.result}"
  cluster_spec       = var.cluster_spec
  worker_vswitch_ids = [alicloud_vswitch.vswitch.id]
  new_nat_gateway    = true
  pod_cidr           = var.pod_cidr
  service_cidr       = var.service_cidr
  proxy_mode         = var.proxy_mode
  version            = var.kubernetes_version
}

# 集群添加节点
resource "alicloud_cs_kubernetes_node_pool" "default" {
  node_pool_name       = "tf-test-${random_integer.default.result}"
  cluster_id           = alicloud_cs_managed_kubernetes.default.id
  vswitch_ids          = [alicloud_vswitch.vswitch.id]
  instance_types       = [var.instance_types]
  system_disk_category = var.system_disk_category
  system_disk_size     = 40
  desired_size         = 1
}

# 创建edas微服务空间
resource "alicloud_edas_namespace" "default" {
  debug_enable         = false
  namespace_logical_id = "${local.region}:${random_integer.default.result}"
  namespace_name       = "tf-namespace-name-${random_integer.default.result}"
  description          = "tf-test"
}

# 微服务空间导入集群
resource "alicloud_edas_k8s_cluster" "default" {
  cs_cluster_id = alicloud_cs_kubernetes_node_pool.default.cluster_id
  namespace_id  = alicloud_edas_namespace.default.namespace_logical_id
}

# 集群中部署应用
resource "alicloud_edas_k8s_application" "default" {
  application_name = "tf-k8s-app-${random_integer.default.result}"
  cluster_id       = alicloud_edas_k8s_cluster.default.id
  package_type     = "FatJar"
  package_url      = var.package_url
  jdk              = var.jdk
  replicas         = 0 # 根据您的需要，设置应用程序部署数量
  readiness        = "{\"failureThreshold\": 3,\"initialDelaySeconds\": 5,\"successThreshold\": 1,\"timeoutSeconds\": 1,\"tcpSocket\":{\"port\":18081}}"
  liveness         = "{\"failureThreshold\": 3,\"initialDelaySeconds\": 5,\"successThreshold\": 1,\"timeoutSeconds\": 1,\"tcpSocket\":{\"port\":18081}}"
  timeouts {
    create = "60m" # 自定义创建超时时间为60分钟
  }
}
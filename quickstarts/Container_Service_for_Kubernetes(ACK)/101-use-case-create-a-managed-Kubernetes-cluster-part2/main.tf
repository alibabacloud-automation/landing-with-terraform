provider "alicloud" {
  region = "cn-zhangjiakou"
}
# 默认资源名称
variable "name" {
  default = "my-first-kubernetes-demo"
}
# 日志服务项目名称
variable "log_project_name" {
  default = "my-first-kubernetes-sls-demo"
}
# 可用区
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}
# 节点ECS实例配置
data "alicloud_instance_types" "default" {
  availability_zone    = data.alicloud_zones.default.zones[0].id
  cpu_core_count       = 2
  memory_size          = 4
  kubernetes_node_role = "Worker"
}
# 专有网络
resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.1.0.0/21"
}
# 交换机
resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "10.1.1.0/24"
  zone_id      = data.alicloud_zones.default.zones[0].id
}

# kubernetes托管版
resource "alicloud_cs_managed_kubernetes" "default" {
  worker_vswitch_ids = [alicloud_vswitch.default.id]
  # kubernetes集群名称的前缀。与name冲突。如果指定，terraform将使用它来构建唯一的集群名称。默认为“ Terraform-Creation”。
  name_prefix = var.name
  # 是否在创建kubernetes集群时创建新的nat网关。默认为true。
  new_nat_gateway = true
  # pod网络的CIDR块。当cluster_network_type设置为flannel，你必须设定该参数。它不能与VPC CIDR相同，并且不能与VPC中的Kubernetes集群使用的CIDR相同，也不能在创建后进行修改。集群中允许的最大主机数量：256。
  pod_cidr = "172.20.0.0/16"
  # 服务网络的CIDR块。它不能与VPC CIDR相同，不能与VPC中的Kubernetes集群使用的CIDR相同，也不能在创建后进行修改。
  service_cidr = "172.21.0.0/20"
  # 是否为API Server创建Internet负载均衡。默认为false。
  slb_internet_enabled = true

  # 导出集群的证书相关文件到 /tmp 目录，下同
  client_cert     = "/tmp/client-cert.pem"
  client_key      = "/tmp/client-key.pem"
  cluster_ca_cert = "/tmp/cluster-ca-cert.pem"
}

resource "alicloud_cs_kubernetes_node_pool" "default" {
  name        = var.name
  cluster_id  = alicloud_cs_managed_kubernetes.default.id
  vswitch_ids = [alicloud_vswitch.default.id]
  # ssh登录集群节点的密码。您必须指定password或key_name kms_encrypted_password字段。
  password = "Yourpassword1234"
  # kubernetes集群的总工作节点数。
  desired_size = 3
  # 是否为kubernetes的节点安装云监控。
  install_cloud_monitor = true
  # 节点的ECS实例类型。为单个AZ集群指定一种类型，为MultiAZ集群指定三种类型。您可以通过数据源instance_types获得可用的kubernetes主节点实例类型
  instance_types = ["ecs.n4.large"]
  # 节点的系统磁盘类别。其有效值为cloud_ssd和cloud_efficiency。默认为cloud_efficiency。
  system_disk_category = "cloud_efficiency"
  system_disk_size     = 40
  data_disks {
    category = "cloud_ssd"
    size     = "100"
  }
}

data "alicloud_cs_cluster_credential" "auth" {
  cluster_id                 = alicloud_cs_managed_kubernetes.default.id
  temporary_duration_minutes = 60
  output_file                = "/tmp/config"
}
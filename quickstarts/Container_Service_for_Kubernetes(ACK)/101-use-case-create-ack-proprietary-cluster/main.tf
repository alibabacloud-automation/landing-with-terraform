provider "alicloud" {
  region = var.region_id
}

variable "region_id" {
  type    = string
  default = "cn-hangzhou"
}

# 定义资源的名称或标签。
variable "name" {
  default = "tf-example"
}

# 指定现有的vpc_id。如果为空，则表示创建一个新的VPC。
variable "vpc_id" {
  description = "Existing vpc id used to create several vswitches and other resources."
  default     = ""
}

# 当没有指定vpc_id时，定义了新VPC的CIDR地址，即IP地址范围。
variable "vpc_cidr" {
  description = "The cidr block used to launch a new vpc when 'vpc_id' is not specified."
  default     = "10.0.0.0/8"
}

# 指定现有的vSwitch（虚拟交换机）ID。
variable "vswitch_ids" {
  description = "List of existing vswitch id."
  type        = list(string)
  default     = []
}


variable "vswitch_cidrs" { # 创建新的vSwitch，需要填写三个且不重叠的CIDR地址块。
  description = "List of cidr blocks used to create several new vswitches when 'vswitch_ids' is not specified."
  type        = list(string)
  default     = ["10.1.0.0/16", "10.2.0.0/16", "10.3.0.0/16"]
}

# 指定网络组件Terway配置。
variable "terway_vswitch_ids" {
  description = "List of existing vswitch ids for terway."
  type        = list(string)
  default     = []
}

# 当没有指定terway_vswitch_ids时，用于创建Terway使用的vSwitch的CIDR地址块。
variable "terway_vswitch_cidrs" {
  description = "List of cidr blocks used to create several new vswitches when 'terway_vswitch_cidrs' is not specified."
  type        = list(string)
  default     = ["10.4.0.0/16", "10.5.0.0/16", "10.6.0.0/16"]
}

# 指定ACK集群安装的组件。声明每个组件的名称和对应配置。
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
      "name"   = "csi-plugin",
      "config" = "",
    },
    {
      "name"   = "csi-provisioner",
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
    }
  ]
}

# 查询用于获取支持增强型网关NAT的区域。
data "alicloud_enhanced_nat_available_zones" "enhanced" {
}

# 当没有提供vpc_id变量时，这个资源将创建一个新的专有网络，其CIDR块由vpc_cidr变量指定。
resource "alicloud_vpc" "vpc" {
  count      = var.vpc_id == "" ? 1 : 0
  cidr_block = var.vpc_cidr
}

# 当没有提供vswitch_ids变量时，默认会根据填写的vswitch_cidrs创建新的vSwitch。
resource "alicloud_vswitch" "vswitches" {
  count      = length(var.vswitch_ids) > 0 ? 0 : length(var.vswitch_cidrs)
  vpc_id     = var.vpc_id == "" ? join("", alicloud_vpc.vpc.*.id) : var.vpc_id
  cidr_block = element(var.vswitch_cidrs, count.index)
  zone_id    = data.alicloud_enhanced_nat_available_zones.enhanced.zones[count.index].zone_id
}

# 当没有提供terway_vswitch_ids变量时，默认会根据填写的vswitch_cidrs创建Terway使用的vSwitch。
resource "alicloud_vswitch" "terway_vswitches" {
  count      = length(var.terway_vswitch_ids) > 0 ? 0 : length(var.terway_vswitch_cidrs)
  vpc_id     = var.vpc_id == "" ? join("", alicloud_vpc.vpc.*.id) : var.vpc_id
  cidr_block = element(var.terway_vswitch_cidrs, count.index)
  zone_id    = data.alicloud_enhanced_nat_available_zones.enhanced.zones[count.index].zone_id
}

# 查询当前阿里云用户的资源组。
data "alicloud_resource_manager_resource_groups" "default" {
  status = "OK"
}

# 查询阿里云的ECS实例类型。
data "alicloud_instance_types" "default" {
  count                = 3
  availability_zone    = data.alicloud_enhanced_nat_available_zones.enhanced.zones[0].zone_id
  cpu_core_count       = 4
  memory_size          = 8
  kubernetes_node_role = "Master"
  system_disk_category = "cloud_essd"
}

# 创建ACK专有集群，配置包括控制面虚拟交换机、Pod虚拟交换机、实例类型、磁盘、密码、Service网络地址段等。
resource "alicloud_cs_kubernetes" "default" {
  master_vswitch_ids    = length(var.vswitch_ids) > 0 ? split(",", join(",", var.vswitch_ids)) : length(var.vswitch_cidrs) < 1 ? [] : split(",", join(",", alicloud_vswitch.vswitches.*.id))                             # 查询支持增强型NAT的可用区列表。
  pod_vswitch_ids       = length(var.terway_vswitch_ids) > 0 ? split(",", join(",", var.terway_vswitch_ids)) : length(var.terway_vswitch_cidrs) < 1 ? [] : split(",", join(",", alicloud_vswitch.terway_vswitches.*.id)) # 使用Terway时pod网络的vswitch地址段。
  master_instance_types = [data.alicloud_instance_types.default.0.instance_types.0.id, data.alicloud_instance_types.default.1.instance_types.0.id, data.alicloud_instance_types.default.2.instance_types.0.id]           # 控制面节点的实例类型。
  master_disk_category  = "cloud_ssd"                                                                                                                                                                                    # 控制面节点系统盘类型。
  password              = "Yourpassword1234"                                                                                                                                                                             # SSH登录密码。
  service_cidr          = "172.18.0.0/16"                                                                                                                                                                                # Service网络地址段。
  load_balancer_spec    = "slb.s1.small"                                                                                                                                                                                 # 负载均衡规格。
  install_cloud_monitor = "true"                                                                                                                                                                                         # 安装云监控服务。
  resource_group_id     = data.alicloud_resource_manager_resource_groups.default.groups.0.id                                                                                                                             # 集群所属资源组ID，实现不同资源的隔离。
  deletion_protection   = "false"                                                                                                                                                                                        # 集群删除保护，防止通过控制台或API误删除集群。
  timezone              = "Asia/Shanghai"                                                                                                                                                                                # 集群使用的时区。
  os_type               = "Linux"                                                                                                                                                                                        # 操作系统平台类型。
  platform              = "AliyunLinux3"                                                                                                                                                                                 # 操作系统发行版。
  cluster_domain        = "cluster.local"                                                                                                                                                                                # 集群本地域名。
  proxy_mode            = "ipvs"                                                                                                                                                                                         # kube-proxy代理模式。
  custom_san            = "www.terraform.io"                                                                                                                                                                             # 自定义证书SAN。
  new_nat_gateway       = "true"                                                                                                                                                                                         # 创建一个新的NAT网关。
  dynamic "addons" {
    for_each = var.cluster_addons
    content {
      name   = lookup(addons.value, "name", var.cluster_addons)
      config = lookup(addons.value, "config", var.cluster_addons)
    }
  }
}
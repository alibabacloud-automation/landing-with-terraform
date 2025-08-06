# 开通ack pro
data "alicloud_ack_service" "open_ack" {
  enable = "On"
  type   = "propayasgo"
}

# 查询实例实例规格
data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.g7"
  sorted_by            = "CPU"
  memory_size          = "16"
}

# 查询实例规格支持的可用区
data "alicloud_zones" "default" {
  available_instance_type    = data.alicloud_instance_types.default.ids.0
  available_slb_address_type = "classic_internet"
}

locals {
  zone1 = data.alicloud_zones.default.ids[length(data.alicloud_zones.default.ids) - 1]
  zone2 = data.alicloud_zones.default.ids[length(data.alicloud_zones.default.ids) - 2]
}

# 创建VPC
resource "alicloud_vpc" "vpc" {
  cidr_block = "10.0.0.0/8"
  vpc_name   = "${var.common_name}-vpc"
}

# 创建VSwitch
resource "alicloud_vswitch" "vswitch1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "10.0.0.0/24"
  zone_id      = local.zone1
  vswitch_name = "${var.common_name}-vsw"
}

resource "alicloud_vswitch" "vswitch2" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "10.0.1.0/24"
  zone_id      = local.zone2
  vswitch_name = "${var.common_name}-vsw"
}

# 创建安全组
resource "alicloud_security_group" "sg" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = "${var.common_name}-sg"
}

resource "alicloud_security_group_rule" "ingress_http" {
  security_group_id = alicloud_security_group.sg.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "80/80"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "ingress_https" {
  security_group_id = alicloud_security_group.sg.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "443/443"
  cidr_ip           = "0.0.0.0/0"
}

# 创建ACK集群
resource "alicloud_cs_managed_kubernetes" "ack" {
  depends_on           = [data.alicloud_ack_service.open_ack, alicloud_ram_role.role, alicloud_ram_role_policy_attachment.attach]
  name                 = var.managed_kubernetes_cluster_name
  cluster_spec         = "ack.pro.small"
  vswitch_ids          = [alicloud_vswitch.vswitch1.id, alicloud_vswitch.vswitch2.id]
  pod_vswitch_ids      = [alicloud_vswitch.vswitch1.id, alicloud_vswitch.vswitch2.id]
  service_cidr         = "192.168.0.0/16"
  new_nat_gateway      = true
  slb_internet_enabled = true
  security_group_id    = alicloud_security_group.sg.id

  addons {
    name = "ack-node-local-dns"
  }
  addons {
    name = "terway-eniip"
    config = jsonencode({
      IPVlan        = "false"
      NetworkPolicy = "false"
      ENITrunking   = "false"
    })
  }
  addons {
    name = "csi-plugin"
  }
  addons {
    name = "csi-provisioner"
  }
  addons {
    name = "storage-operator"
    config = jsonencode({
      CnfsOssEnable = "false"
      CnfsNasEnable = "false"
    })
  }
  addons {
    name     = "nginx-ingress-controller"
    disabled = true
  }
  addons {
    name = "logtail-ds"
    config = jsonencode({
      IngressDashboardEnabled = "true"
    })
  }
  addons {
    name    = "alb-ingress-controller"
    version = ""
    config = jsonencode({
      albIngress = {
        AddressType = "Internet"
        ZoneMappings = {
          "${local.zone1}" = ["${alicloud_vswitch.vswitch1.id}"]
          "${local.zone2}" = ["${alicloud_vswitch.vswitch2.id}"]
        }
        CreateDefaultALBConfig = true
      }
    })
  }

  delete_options {
    delete_mode   = "delete"
    resource_type = "ALB"
  }
  delete_options {
    delete_mode   = "delete"
    resource_type = "SLB"
  }
  delete_options {
    delete_mode   = "delete"
    resource_type = "SLS_Data"
  }
  delete_options {
    delete_mode   = "delete"
    resource_type = "SLS_ControlPlane"
  }
  delete_options {
    delete_mode   = "delete"
    resource_type = "PrivateZone"
  }
}

# 创建节点池
resource "alicloud_cs_kubernetes_node_pool" "node_pool" {
  node_pool_name       = "${var.common_name}-nodepool"
  cluster_id           = alicloud_cs_managed_kubernetes.ack.id
  vswitch_ids          = [alicloud_vswitch.vswitch1.id, alicloud_vswitch.vswitch2.id]
  instance_types       = [data.alicloud_instance_types.default.ids.0]
  system_disk_category = "cloud_essd"
  system_disk_size     = 120
  desired_size         = 3
  runtime_name         = "containerd"
  runtime_version      = "1.6.28"
}

# 通过ROS在集群内部署资源
resource "random_integer" "default" {
  min = 100000
  max = 999999
}

resource "alicloud_ros_stack" "deploy_k8s_resource" {
  stack_name   = "${var.common_name}-k8s-resource-${random_integer.default.result}"
  template_url = "https://ros-public-templates.oss-cn-hangzhou.aliyuncs.com/ros-templates/documents/solution/micro/build-microservices-on-ack-k8s-resource.tf.yaml"
  parameters {
    parameter_key   = "cluster_id"
    parameter_value = alicloud_cs_managed_kubernetes.ack.id
  }
  disable_rollback = true
  depends_on       = [alicloud_cs_kubernetes_node_pool.node_pool]
}

# 定义本地变量，包含所有要创建的 RAM Role 及其策略
locals {
  cs_roles = [
    {
      name            = "AliyunCSManagedLogRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "集群的日志组件使用此角色来访问您在其他云产品中的资源。"
      policy_name     = "AliyunCSManagedLogRolePolicy"
    },
    {
      name            = "AliyunCSManagedCmsRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "集群的CMS组件使用此角色来访问您在其他云产品中的资源。"
      policy_name     = "AliyunCSManagedCmsRolePolicy"
    },
    {
      name            = "AliyunCSManagedCsiRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "集群的存储组件使用此角色来访问您在其他云产品中的资源。"
      policy_name     = "AliyunCSManagedCsiRolePolicy"
    },
    {
      name            = "AliyunCSManagedCsiPluginRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "集群的存储组件使用此角色来访问您在其他云产品中的资源。"
      policy_name     = "AliyunCSManagedCsiPluginRolePolicy"
    },
    {
      name            = "AliyunCSManagedCsiProvisionerRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "集群的存储组件使用此角色来访问您在其他云产品中的资源。"
      policy_name     = "AliyunCSManagedCsiProvisionerRolePolicy"
    },
    {
      name            = "AliyunCSManagedVKRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "ACK Serverless集群的VK组件使用此角色来访问您在其他云产品中的资源。"
      policy_name     = "AliyunCSManagedVKRolePolicy"
    },
    {
      name            = "AliyunCSServerlessKubernetesRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "集群默认使用此角色来访问您在其他云产品中的资源。"
      policy_name     = "AliyunCSServerlessKubernetesRolePolicy"
    },
    {
      name            = "AliyunCSKubernetesAuditRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "集群审计功能使用此角色来访问您在其他云产品中的资源。"
      policy_name     = "AliyunCSKubernetesAuditRolePolicy"
    },
    {
      name            = "AliyunCSManagedNetworkRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "集群网络组件使用此角色来访问您在其他云产品中的资源。"
      policy_name     = "AliyunCSManagedNetworkRolePolicy"
    },
    {
      name            = "AliyunCSDefaultRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "集群操作时默认使用此角色来访问您在其他云产品中的资源。"
      policy_name     = "AliyunCSDefaultRolePolicy"
    },
    {
      name            = "AliyunCSManagedKubernetesRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "集群默认使用此角色来访问您在其他云产品中的资源。"
      policy_name     = "AliyunCSManagedKubernetesRolePolicy"
    },
    {
      name            = "AliyunCSManagedArmsRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "集群Arms插件使用此角色来访问您在其他云产品中的资源。"
      policy_name     = "AliyunCSManagedArmsRolePolicy"
    },
    {
      name            = "AliyunCISDefaultRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "容器服务（CS）智能运维使用此角色来访问您在其他云产品中的资源。"
      policy_name     = "AliyunCISDefaultRolePolicy"
    },
    {
      name            = "AliyunOOSLifecycleHook4CSRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"oos.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "集群扩缩容节点池依赖OOS服务，OOS使用此角色来访问您在其他云产品中的资源。"
      policy_name     = "AliyunOOSLifecycleHook4CSRolePolicy"
    },
    {
      name            = "AliyunCSManagedAutoScalerRole"
      policy_document = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}"
      description     = "集群的弹性伸缩组件使用此角色来访问您在其他云产品中的资源。"
      policy_name     = "AliyunCSManagedAutoScalerRolePolicy"
    }
  ]
}

// 查询RAM角色列表
data "alicloud_ram_roles" "roles" {
  policy_type = "Custom"
  name_regex  = "^Aliyun.*Role$"
}

locals {
  # 提取所有所需RAM角色name
  all_role_names = [for role in local.cs_roles : role.name]
  # 提取已存在的RAM角色name
  created_role_names = [for role in data.alicloud_ram_roles.roles.roles : role.name]
  # 计算补集：即找出还未创建的所需RAM角色
  complement_names = setsubtract(local.all_role_names, local.created_role_names)
  # 待创建的RAM角色
  complement_roles = [for role in local.cs_roles : role if contains(local.complement_names, role.name)]
}

// 创建角色。
resource "alicloud_ram_role" "role" {
  for_each                    = { for r in local.complement_roles : r.name => r }
  role_name                   = each.value.name
  assume_role_policy_document = each.value.policy_document
  description                 = each.value.description
  force                       = true
}

// 角色关联系统权限。
resource "alicloud_ram_role_policy_attachment" "attach" {
  for_each    = { for r in local.complement_roles : r.name => r }
  policy_name = each.value.policy_name
  policy_type = "System"
  role_name   = each.value.name
  depends_on  = [alicloud_ram_role.role]
}

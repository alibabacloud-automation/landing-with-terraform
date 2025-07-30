# 开通sls服务
data "alicloud_log_service" "open_sls" {
  enable = "On"
}

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

resource "alicloud_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  vpc_name   = "${var.common_name}-vpc"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.0.0/24"
  zone_id      = data.alicloud_zones.default.ids.0
  vswitch_name = "${var.common_name}-${data.alicloud_zones.default.ids.0}-vsw"
}

resource "alicloud_cs_managed_kubernetes" "ack" {
  depends_on                   = [data.alicloud_log_service.open_sls, data.alicloud_ack_service.open_ack, alicloud_ram_role_policy_attachment.attach]
  name                         = var.ack_name
  cluster_spec                 = "ack.pro.small"
  vswitch_ids                  = [alicloud_vswitch.vsw.id]
  pod_vswitch_ids              = [alicloud_vswitch.vsw.id]
  service_cidr                 = "172.16.0.0/16"
  new_nat_gateway              = true
  slb_internet_enabled         = false
  is_enterprise_security_group = false

  addons {
    name = "security-inspector"
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
    name = "logtail-ds"
    config = jsonencode({
      IngressDashboardEnabled = "true"
    })
  }
  addons {
    name = "nginx-ingress-controller"
    config = jsonencode({
      IngressSlbNetworkType = "internet"
      IngressSlbSpec        = "slb.s2.small"
    })
  }
  addons {
    name = "ack-node-local-dns"
  }
  addons {
    name = "arms-prometheus"
  }
  addons {
    name = "ack-node-problem-detector"
    config = jsonencode({
      sls_project_name = ""
    })
  }
}

resource "alicloud_cs_kubernetes_node_pool" "node_pool" {
  node_pool_name       = "${var.common_name}-nodepool"
  cluster_id           = alicloud_cs_managed_kubernetes.ack.id
  vswitch_ids          = [alicloud_vswitch.vsw.id]
  instance_types       = [data.alicloud_instance_types.default.ids.0]
  system_disk_category = "cloud_essd"
  system_disk_size     = 40
  desired_size         = 3

  runtime_name    = "containerd"
  runtime_version = "1.6.20"
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
}

// 角色关联系统权限。
resource "alicloud_ram_role_policy_attachment" "attach" {
  for_each    = { for r in local.complement_roles : r.name => r }
  policy_name = each.value.policy_name
  policy_type = "System"
  role_name   = each.value.name
  depends_on  = [alicloud_ram_role.role]
}
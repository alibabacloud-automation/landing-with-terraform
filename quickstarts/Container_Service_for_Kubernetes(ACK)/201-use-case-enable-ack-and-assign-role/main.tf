provider "alicloud" {
  region = var.region_id
}

variable "region_id" {
  type    = string
  default = "cn-hangzhou"
}

// 开通容器服务ACK。
data "alicloud_ack_service" "open" {
  enable = "On"
  type   = "propayasgo"
}

// 所需RAM角色。
variable "roles" {
  type = list(object({
    name            = string
    policy_document = string
    description     = string
    policy_name     = string
  }))
  default = [
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
  all_role_names = [for role in var.roles : role.name]
  # 提取已存在的RAM角色name
  created_role_names = [for role in data.alicloud_ram_roles.roles.roles : role.name]
  # 计算补集：即找出还未创建的所需RAM角色
  complement_names = setsubtract(local.all_role_names, local.created_role_names)
  # 待创建的RAM角色
  complement_roles = [for role in var.roles : role if contains(local.complement_names, role.name)]
}

// 创建角色。
resource "alicloud_ram_role" "role" {
  for_each    = { for r in local.complement_roles : r.name => r }
  name        = each.value.name
  document    = each.value.policy_document
  description = each.value.description
  force       = true
}

// 角色关联系统权限。
resource "alicloud_ram_role_policy_attachment" "attach" {
  for_each    = { for r in local.complement_roles : r.name => r }
  policy_name = each.value.policy_name
  policy_type = "System"
  role_name   = each.value.name
  depends_on  = [alicloud_ram_role.role]
}
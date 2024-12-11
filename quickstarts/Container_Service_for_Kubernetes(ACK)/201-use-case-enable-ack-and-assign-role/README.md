## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上开通ACK并授权服务角色，涉及到ACK相关服务角色的创建。
详情可查看[使用Terraform首次开通ACK并授权服务角色](http://help.aliyun.com/document_detail/606722.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to enable ACK and authorize service-linked roles on Alibaba Cloud, which involves the creation of ACK-related service-linked roles.
More details in [Enable ACK and assign role](https://help.aliyun.com/document_detail/606722.html).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_role.role](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_role_policy_attachment.attach](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment) | resource |
| [alicloud_ack_service.open](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ack_service) | data source |
| [alicloud_ram_roles.roles](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ram_roles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | n/a | `string` | `"cn-hangzhou"` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | 所需RAM角色。 | <pre>list(object({<br/>    name            = string<br/>    policy_document = string<br/>    description     = string<br/>    policy_name     = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "description": "集群的日志组件使用此角色来访问您在其他云产品中的资源。",<br/>    "name": "AliyunCSManagedLogRole",<br/>    "policy_document": "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}",<br/>    "policy_name": "AliyunCSManagedLogRolePolicy"<br/>  },<br/>  {<br/>    "description": "集群的CMS组件使用此角色来访问您在其他云产品中的资源。",<br/>    "name": "AliyunCSManagedCmsRole",<br/>    "policy_document": "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}",<br/>    "policy_name": "AliyunCSManagedCmsRolePolicy"<br/>  },<br/>  {<br/>    "description": "集群的存储组件使用此角色来访问您在其他云产品中的资源。",<br/>    "name": "AliyunCSManagedCsiRole",<br/>    "policy_document": "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}",<br/>    "policy_name": "AliyunCSManagedCsiRolePolicy"<br/>  },<br/>  {<br/>    "description": "集群的存储组件使用此角色来访问您在其他云产品中的资源。",<br/>    "name": "AliyunCSManagedCsiPluginRole",<br/>    "policy_document": "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}",<br/>    "policy_name": "AliyunCSManagedCsiPluginRolePolicy"<br/>  },<br/>  {<br/>    "description": "集群的存储组件使用此角色来访问您在其他云产品中的资源。",<br/>    "name": "AliyunCSManagedCsiProvisionerRole",<br/>    "policy_document": "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}",<br/>    "policy_name": "AliyunCSManagedCsiProvisionerRolePolicy"<br/>  },<br/>  {<br/>    "description": "ACK Serverless集群的VK组件使用此角色来访问您在其他云产品中的资源。",<br/>    "name": "AliyunCSManagedVKRole",<br/>    "policy_document": "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}",<br/>    "policy_name": "AliyunCSManagedVKRolePolicy"<br/>  },<br/>  {<br/>    "description": "集群默认使用此角色来访问您在其他云产品中的资源。",<br/>    "name": "AliyunCSServerlessKubernetesRole",<br/>    "policy_document": "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}",<br/>    "policy_name": "AliyunCSServerlessKubernetesRolePolicy"<br/>  },<br/>  {<br/>    "description": "集群审计功能使用此角色来访问您在其他云产品中的资源。",<br/>    "name": "AliyunCSKubernetesAuditRole",<br/>    "policy_document": "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}",<br/>    "policy_name": "AliyunCSKubernetesAuditRolePolicy"<br/>  },<br/>  {<br/>    "description": "集群网络组件使用此角色来访问您在其他云产品中的资源。",<br/>    "name": "AliyunCSManagedNetworkRole",<br/>    "policy_document": "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}",<br/>    "policy_name": "AliyunCSManagedNetworkRolePolicy"<br/>  },<br/>  {<br/>    "description": "集群操作时默认使用此角色来访问您在其他云产品中的资源。",<br/>    "name": "AliyunCSDefaultRole",<br/>    "policy_document": "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}",<br/>    "policy_name": "AliyunCSDefaultRolePolicy"<br/>  },<br/>  {<br/>    "description": "集群默认使用此角色来访问您在其他云产品中的资源。",<br/>    "name": "AliyunCSManagedKubernetesRole",<br/>    "policy_document": "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}",<br/>    "policy_name": "AliyunCSManagedKubernetesRolePolicy"<br/>  },<br/>  {<br/>    "description": "集群Arms插件使用此角色来访问您在其他云产品中的资源。",<br/>    "name": "AliyunCSManagedArmsRole",<br/>    "policy_document": "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}",<br/>    "policy_name": "AliyunCSManagedArmsRolePolicy"<br/>  },<br/>  {<br/>    "description": "容器服务（CS）智能运维使用此角色来访问您在其他云产品中的资源。",<br/>    "name": "AliyunCISDefaultRole",<br/>    "policy_document": "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}",<br/>    "policy_name": "AliyunCISDefaultRolePolicy"<br/>  },<br/>  {<br/>    "description": "集群扩缩容节点池依赖OOS服务，OOS使用此角色来访问您在其他云产品中的资源。",<br/>    "name": "AliyunOOSLifecycleHook4CSRole",<br/>    "policy_document": "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"oos.aliyuncs.com\"]}}],\"Version\":\"1\"}",<br/>    "policy_name": "AliyunOOSLifecycleHook4CSRolePolicy"<br/>  },<br/>  {<br/>    "description": "集群的弹性伸缩组件使用此角色来访问您在其他云产品中的资源。",<br/>    "name": "AliyunCSManagedAutoScalerRole",<br/>    "policy_document": "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":[\"cs.aliyuncs.com\"]}}],\"Version\":\"1\"}",<br/>    "policy_name": "AliyunCSManagedAutoScalerRolePolicy"<br/>  }<br/>]</pre> | no |
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Enable ACK and assign role](http://help.aliyun.com/document_detail/606722.htm) 

<!-- docs-link --> 
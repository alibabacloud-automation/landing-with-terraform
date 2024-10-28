## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建RDS的服务关联角色。
本示例来自[通过 Terraform 管理RDS服务关联角色](http://help.aliyun.com/document_detail/461381.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create service-linked role for ApsaraDB RDS for PostgreSQL on Alibaba Cloud.
This example is from [Manage RDS service-linked roles](http://help.aliyun.com/document_detail/461381.htm).
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
| [alicloud_rds_service_linked_role.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rds_service_linked_role) | resource |
| [alicloud_resource_manager_roles.slr](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/resource_manager_roles) | data source |

## Inputs

No inputs.
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Manage RDS service linked roles](http://help.aliyun.com/document_detail/461381.htm) 

<!-- docs-link --> 
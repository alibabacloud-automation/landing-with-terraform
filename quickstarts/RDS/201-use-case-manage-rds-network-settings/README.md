## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上申请、修改和释放RDS PostgreSQL实例的外网地址，以及查询和切换交换机，涉及到RDS PostgreSQL实例的创建,外网地址的申请与交换机详情的查询等。
详情可查看[通过 Terraform 管理数据库连接的网络配置](http://help.aliyun.com/document_detail/456030.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to apply for a public endpoint for an ApsaraDB RDS for PostgreSQL instance and how to modify and release the public endpoint. This topic also describes how to query and change the vSwitch of an ApsaraDB RDS for PostgreSQL instance. 
More details in [Manage RDS network settings](http://help.aliyun.com/document_detail/456030.htm).
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
| [alicloud_db_connection.extranet](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_connection) | resource |
| [alicloud_db_database.db](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_database) | resource |
| [alicloud_db_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_vpc.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"pg.n2.2c.2m"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-heyuan"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-heyuan-b"` | no |
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Manage RDS network settings](http://help.aliyun.com/document_detail/456030.htm) 

<!-- docs-link --> 
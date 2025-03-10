## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建一个 AnalyticDB PostgreSQL 实例及数据库账号。
详情可查看[通过 Terraform 创建 AnalyticDB PostgreSQL 数据库账号](https://help.aliyun.com/document_detail/2842793.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create database account for AnalyticDB PostgreSQL on Alibaba Cloud.
More details in [Create database account for AnalyticDB PostgreSQL instance](https://help.aliyun.com/document_detail/2842793.html).
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
| [alicloud_gpdb_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/gpdb_account) | resource |
| [alicloud_gpdb_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/gpdb_instance) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | n/a | `string` | `"gpdb.group.segsdx1"` | no |
| <a name="input_instance_spec"></a> [instance\_spec](#input\_instance\_spec) | n/a | `string` | `"2C16G"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shenzhen"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-shenzhen-e"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create database account for AnalyticDB PostgreSQL instance](https://help.aliyun.com/document_detail/2842793.html) 

<!-- docs-link --> 
## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建 AnalyticDB MySQL 湖仓版集群以及数据库高权限账号。
详情可查看[通过 Terraform 创建ADB MySQL数据库账号](https://help.aliyun.com/document_detail/2842815.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create AnalyticDB MySQL database account on Alibaba Cloud.
More details in [Create ADB MySQL database account](https://help.aliyun.com/document_detail/2842815.html).
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
| [alicloud_adb_db_cluster_lake_version.CreateInstance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/adb_db_cluster_lake_version) | resource |
| [alicloud_adb_lake_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/adb_lake_account) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shenzhen"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-shenzhen-e"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create ADB MySQL database account](https://help.aliyun.com/document_detail/2842815.html) 

<!-- docs-link --> 
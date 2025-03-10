## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建一个ClickHouse集群，并为其创建一个数据库账号。
详情可查看[通过Terraform新建ClickHouse集群并为其创建数据库账号](https://help.aliyun.com/document_detail/2835286.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create an ApsaraDB ClickHouse cluster and database account on Alibaba Cloud.
More details in [Create an ApsaraDB ClickHouse cluster and database account](https://help.aliyun.com/document_detail/2835286.html).
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
| [alicloud_click_house_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/click_house_account) | resource |
| [alicloud_click_house_db_cluster.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/click_house_db_cluster) | resource |
| [alicloud_vpc.vpc1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_click_house_regions.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/click_house_regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_description"></a> [account\_description](#input\_account\_description) | n/a | `string` | `"createdByTerraform"` | no |
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | n/a | `string` | `"test_account"` | no |
| <a name="input_account_password"></a> [account\_password](#input\_account\_password) | n/a | `string` | `"testPassword123%"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example-ClickHouse"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-qingdao"` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | n/a | `string` | `"cloud_essd"` | no |
| <a name="input_type"></a> [type](#input\_type) | n/a | `string` | `"Normal"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create an ApsaraDB ClickHouse cluster and database account](https://help.aliyun.com/document_detail/2835286.html) 

<!-- docs-link --> 
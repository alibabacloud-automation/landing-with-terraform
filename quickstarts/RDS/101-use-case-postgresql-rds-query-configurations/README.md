## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云查询RDS PostgreSQL实例的相关配置，展示了对实例可用区资源，可购买的实例规格，实例地域信息，实例列表等资源的查询。
本示例来自[通过 Terraform 查询RDS实例相关配置](http://help.aliyun.com/document_detail/456026.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to to query the configurations of an ApsaraDB RDS for PostgreSQL instance on Alibaba Cloud, which involves the query of instance resources such as instance zones resources, purchasable instance specifications, instance region information, instance lists, etc.
This example is from [Query RDS instance configurations](http://help.aliyun.com/document_detail/456026.htm).
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
| [alicloud_db_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance) | resource |
| [alicloud_vpc.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.main](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_db_instance_classes.queryclasses](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_instance_classes) | data source |
| [alicloud_db_instances.queryinstance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_instances) | data source |
| [alicloud_db_instances.queryinstances](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_instances) | data source |
| [alicloud_db_zones.queryzones](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/db_zones) | data source |
| [alicloud_regions.query_regions](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"pg.n2.2c.2m"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-hangzhou-b"` | no |
<!-- END_TF_DOCS -->
## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Postgresql RDS query configurations](http://help.aliyun.com/document_detail/456026.htm) 

<!-- docs-link --> 
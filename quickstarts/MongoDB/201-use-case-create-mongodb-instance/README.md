## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建云数据库 MongoDB 版实例，涉及到 MongoDB 实例资源，支持副本集实例，支持副本集实例的 MongoDB 分片实例资源的创建。
详情可查看[Terraform集成示例创建MongoDB实例](https://help.aliyun.com/zh/mongodb/developer-reference/terraform-integration-example)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create an ApsaraDB for MongoDB instance on Alibaba Cloud, which involves the creation of MongoDB instance and MongoDB sharding instance.
More details in [Integrate ApsaraDB for MongoDB by using Terraform](https://help.aliyun.com/zh/mongodb/developer-reference/terraform-integration-example).
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
| [alicloud_mongodb_instance.singleNode](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/mongodb_instance) | resource |
| [alicloud_vpc.vpc1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_mongodb_zones.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/mongodb_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | 声明变量名: name | `string` | `"terraform-example-1125"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-heyuan"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create MongoDB instance](https://help.aliyun.com/zh/mongodb/developer-reference/terraform-integration-example) 

<!-- docs-link --> 
## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建和管理Kafka SASL用户。
详情可查看[通过 Terraform 管理Kafka SASL用户](https://help.aliyun.com/document_detail/2618411.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create and manage SASL users in ApsaraMQ for Kafka on Alibaba Cloud.
More details in [Manage Kafka SASL users](https://help.aliyun.com/document_detail/2618411.html).
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
| [alicloud_alikafka_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alikafka_instance) | resource |
| [alicloud_alikafka_sasl_user.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alikafka_sasl_user) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_alikafka_sasl_users.sasl_users_ds](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/alikafka_sasl_users) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | n/a | `string` | `"alikafkaInstanceName"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shenzhen"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-shenzhen-f"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Manage Kafka SASL users](https://help.aliyun.com/document_detail/2618411.html) 

<!-- docs-link --> 
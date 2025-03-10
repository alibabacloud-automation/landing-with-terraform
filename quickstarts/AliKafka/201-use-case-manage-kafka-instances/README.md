## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上使用Terraform的alicloud_alikafka_instance资源提供一系列的参数来管理Kafka实例，涉及到 Kafka实例的创建与查询。
详情可查看[通过 Terraform 管理 Kafka 实例](https://help.aliyun.com/document_detail/2618253.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to manage ApsaraMQ for Kafka instances on Alibaba Cloud, which involves the creation and query of Kafka instance.
More details in [Manage Kafka instance](https://help.aliyun.com/document_detail/2618253.html).
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
| [alicloud_security_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_alikafka_instances.instances_ds](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/alikafka_instances) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | n/a | `string` | `"alikafkaInstanceName"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shenzhen"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-shenzhen-f"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Manage Kafka instance](https://help.aliyun.com/document_detail/2618253.html) 

<!-- docs-link --> 
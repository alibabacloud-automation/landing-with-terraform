## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上如何通过Terraform提供的alicloud_alikafka_topic资源创建、删除及查询Topic。
详情可查看[通过 Terraform 管理 Kafka Topic](https://help.aliyun.com/document_detail/2606119.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to use the alicloud_alikafka_topic resource provided by Terraform to create, delete, and query topics.
More details in [Manage Kafka topics](https://help.aliyun.com/document_detail/2606119.html).
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
| [alicloud_alikafka_topic.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alikafka_topic) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_alikafka_topics.topics_ds](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/alikafka_topics) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | n/a | `string` | `"alikafkaInstanceName"` | no |
| <a name="input_partition_num"></a> [partition\_num](#input\_partition\_num) | n/a | `string` | `"12"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shenzhen"` | no |
| <a name="input_remark"></a> [remark](#input\_remark) | n/a | `string` | `"kafka_topic_remark"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-shenzhen-f"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Manage Kafka topics](https://help.aliyun.com/document_detail/2606119.html) 

<!-- docs-link --> 
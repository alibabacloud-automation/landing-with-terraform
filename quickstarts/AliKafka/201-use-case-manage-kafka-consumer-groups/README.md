## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上使用Terraform提供的alicloud_alikafka_consumer_group资源来创建和管理阿里云Kafka消费者组（Consumer Group）。
详情可查看[通过 Terraform 管理 Kafka Consumer Group](https://help.aliyun.com/zh/apsaramq-for-kafka/cloud-message-queue-for-kafka/developer-reference/use-terraform-to-manage-kafka-consumer-groups)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to use the alicloud_alikafka_consumer_group resource provided by Terraform to create and manage consumer groups in ApsaraMQ for Kafka. 
More details in [Manage Kafka consumer groups](https://help.aliyun.com/zh/apsaramq-for-kafka/cloud-message-queue-for-kafka/developer-reference/use-terraform-to-manage-kafka-consumer-groups).
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
| [alicloud_alikafka_consumer_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alikafka_consumer_group) | resource |
| [alicloud_alikafka_instance.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alikafka_instance) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_alikafka_consumer_groups.consumer_groups_ds](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/alikafka_consumer_groups) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | n/a | `string` | `"tf-example"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | n/a | `string` | `"alikafkaInstanceName"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shenzhen"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-shenzhen-f"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Manage Kafka consumer groups](https://help.aliyun.com/zh/apsaramq-for-kafka/cloud-message-queue-for-kafka/developer-reference/use-terraform-to-manage-kafka-consumer-groups) 

<!-- docs-link --> 
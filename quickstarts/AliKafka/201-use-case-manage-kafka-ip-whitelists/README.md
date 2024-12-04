## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上为Kafka实例添加以及删除白名单。
详情可查看[通过 Terraform 管理Kafka IP白名单](https://help.aliyun.com/zh/apsaramq-for-kafka/cloud-message-queue-for-kafka/developer-reference/use-terraform-to-manage-ip-address-whitelists)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to add IP addresses or CIDR blocks to or remove IP addresses or CIDR blocks from IP address whitelists for Kafka instance on Alibaba Cloud.
More details in [Manage Kafka IP whitelists](https://help.aliyun.com/zh/apsaramq-for-kafka/cloud-message-queue-for-kafka/developer-reference/use-terraform-to-manage-ip-address-whitelists).
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
| [alicloud_alikafka_instance_allowed_ip_attachment.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/alikafka_instance_allowed_ip_attachment) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | n/a | `string` | `"alikafkaInstanceName"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shenzhen"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | n/a | `string` | `"cn-shenzhen-f"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Manage Kafka IP whitelists](https://help.aliyun.com/zh/apsaramq-for-kafka/cloud-message-queue-for-kafka/developer-reference/use-terraform-to-manage-ip-address-whitelists) 

<!-- docs-link --> 
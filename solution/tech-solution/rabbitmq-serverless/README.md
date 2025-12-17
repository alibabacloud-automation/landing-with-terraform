## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于实现解决方案[云消息队列 RabbitMQ 实践](https://www.aliyun.com/solution/tech-solution/rabbitmq-serverless),  涉及到RabbitMQ实例、RAM 用户等资源的创建。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to implement solution [RabbitMQ Tutorial](https://www.aliyun.com/solution/tech-solution/rabbitmq-serverless). It involves the creation, and deployment of resources such as a RabbitMQ instance, and RAM users.
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_amqp_binding.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/amqp_binding) | resource |
| [alicloud_amqp_exchange.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/amqp_exchange) | resource |
| [alicloud_amqp_instance.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/amqp_instance) | resource |
| [alicloud_amqp_queue.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/amqp_queue) | resource |
| [alicloud_amqp_static_account.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/amqp_static_account) | resource |
| [alicloud_amqp_virtual_host.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/amqp_virtual_host) | resource |
| [alicloud_ram_access_key.ramak](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_access_key) | resource |
| [alicloud_ram_policy.policy](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_policy) | resource |
| [alicloud_ram_user.ram_user](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_user) | resource |
| [alicloud_ram_user_policy_attachment.attach_policy_to_user](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_user_policy_attachment) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->
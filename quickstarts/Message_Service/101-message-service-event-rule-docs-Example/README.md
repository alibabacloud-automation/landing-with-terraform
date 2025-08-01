## Introduction

This example is used to create a `alicloud_message_service_event_rule` resource.

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
| [alicloud_message_service_event_rule.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/message_service_event_rule) | resource |
| [alicloud_message_service_queue.CreateQueue](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/message_service_queue) | resource |
| [alicloud_message_service_subscription.CreateSub](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/message_service_subscription) | resource |
| [alicloud_message_service_topic.CreateTopic](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/message_service_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"terraform-example"` | no |
| <a name="input_queue_name"></a> [queue\_name](#input\_queue\_name) | n/a | `string` | `"tf-exampe-topic2queue"` | no |
| <a name="input_rule_name"></a> [rule\_name](#input\_rule\_name) | n/a | `string` | `"tf-exampe-topic-1"` | no |
| <a name="input_topic_name"></a> [topic\_name](#input\_topic\_name) | n/a | `string` | `"tf-exampe-topic2queue"` | no |
<!-- END_TF_DOCS -->

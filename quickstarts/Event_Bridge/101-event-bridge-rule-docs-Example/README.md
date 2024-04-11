## Introduction

This example is used to create a `alicloud_event_bridge_rule` resource.

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
| [alicloud_event_bridge_event_bus.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/event_bridge_event_bus) | resource |
| [alicloud_event_bridge_rule.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/event_bridge_rule) | resource |
| [alicloud_mns_queue.queue1](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/mns_queue) | resource |
| [alicloud_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"tf-example"` | no |
<!-- END_TF_DOCS -->    
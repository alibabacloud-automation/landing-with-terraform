## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上管理事件总线，涉及到创建事件总线、事件源、连接配置、API 端点与事件规则等操作
详情可查看[通过Terraform管理事件总线](http://help.aliyun.com/document_detail/2579930.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to manage EventBridge on Alibaba Cloud, which involves the creation of resources such as event bus, event source, connection, API destination and rules.
More details in [Manage EventBridge event bus](http://help.aliyun.com/document_detail/2579930.htm).
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
| [alicloud_event_bridge_api_destination.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/event_bridge_api_destination) | resource |
| [alicloud_event_bridge_connection.defaultConnection](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/event_bridge_connection) | resource |
| [alicloud_event_bridge_event_bus.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/event_bridge_event_bus) | resource |
| [alicloud_event_bridge_event_source.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/event_bridge_event_source) | resource |
| [alicloud_event_bridge_rule.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/event_bridge_rule) | resource |
| [alicloud_mns_queue.source](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/mns_queue) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [alicloud_account.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_key_name"></a> [api\_key\_name](#input\_api\_key\_name) | n/a | `string` | `"<使用API_KEY_AUTH鉴权方式的用户名>"` | no |
| <a name="input_api_key_value"></a> [api\_key\_value](#input\_api\_key\_value) | n/a | `string` | `"<使用API_KEY_AUTH鉴权方式的Value>"` | no |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | API端点的URL | `string` | `"http://xxxx:8080/putEventsByAPiKey"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-shanghai"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Manage EventBridge event bus](http://help.aliyun.com/document_detail/2579930.htm) 

<!-- docs-link --> 
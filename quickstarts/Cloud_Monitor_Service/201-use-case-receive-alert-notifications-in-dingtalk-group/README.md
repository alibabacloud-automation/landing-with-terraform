## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于通过钉钉群接收报警通知。
详情可查看[通过钉钉群接收报警通知](https://help.aliyun.com/document_detail/52872.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to enable an alert contact to receive alert notifications in a DingTalk group.
More details in [Enable an alert contact to receive alert notifications in a DingTalk group](https://help.aliyun.com/document_detail/52872.html).
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
| [alicloud_cms_alarm_contact_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_alarm_contact_group) | resource |
| [alicloud_cms_group_metric_rule.this](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_group_metric_rule) | resource |
| [alicloud_cms_monitor_group.default](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cms_monitor_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dingtalk_webhook_endpoint"></a> [dingtalk\_webhook\_endpoint](#input\_dingtalk\_webhook\_endpoint) | DingTalk Webhook URL | `string` | `"https://oapi.dingtalk.com/robot/send?access_token=8e7d6880d9e**************************"` | no |
| <a name="input_name"></a> [name](#input\_name) | 定义一个名称变量，用于资源命名，默认值为 "tf-example-HHM" | `string` | `"tf-example-HHM"` | no |
| <a name="input_region"></a> [region](#input\_region) | 定义区域变量，默认值为 "cn-shenzhen"（深圳） | `string` | `"cn-shenzhen"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Enable an alert contact to receive alert notifications in a DingTalk group](https://help.aliyun.com/document_detail/52872.html) 

<!-- docs-link --> 
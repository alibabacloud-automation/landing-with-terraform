## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上使用事件总线EventBridge将事件的状态变更投递到钉钉，事件总线中定义规则。
详情可查看[通过Terraform实现IaC自动化部署事件总线，事件发送至钉钉](http://help.aliyun.com/document_detail/424947.htm)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to use EventBridge and send event to Dingtalk on Alibaba Cloud, which involves creation of EventBridge rules.
More details in [EventBridge event send to Dingtalk](http://help.aliyun.com/document_detail/424947.htm).
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
| [alicloud_event_bridge_rule.audit_notify](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/event_bridge_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dingtalk_secret_key"></a> [dingtalk\_secret\_key](#input\_dingtalk\_secret\_key) | n/a | `string` | `"SECedd9fbd3eb89aa1986******************"` | no |
| <a name="input_dingtalk_webhook_endpoint"></a> [dingtalk\_webhook\_endpoint](#input\_dingtalk\_webhook\_endpoint) | n/a | `string` | `"https://oapi.dingtalk.com/robot/send?access_token=8e7d6880d9eca81764ee888bdfb03fd795******************"` | no |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | 定义变量 | `string` | `"cn-shenzhen"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [EventBridge event send to Dingtalk](http://help.aliyun.com/document_detail/424947.htm) 

<!-- docs-link --> 
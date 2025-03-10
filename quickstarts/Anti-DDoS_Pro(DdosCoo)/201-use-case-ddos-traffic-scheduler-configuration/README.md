## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上配置DDoS高防流量调度器规则。
详情可查看[通过Terraform配置流量调度器规则](https://help.aliyun.com/document_detail/2536225.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to configure Sec-Traffic Manager rule on Alibaba Cloud.
More details in [Configure Anti DDoS Sec-Traffic Manager](https://help.aliyun.com/document_detail/2536225.html).
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
| [alicloud_ddoscoo_scheduler_rule.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ddoscoo_scheduler_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | n/a | `string` | `"cn-hangzhou"` | no |
| <a name="input_rule_name"></a> [rule\_name](#input\_rule\_name) | n/a | `string` | `"testDDos"` | no |
| <a name="input_rule_type"></a> [rule\_type](#input\_rule\_type) | n/a | `number` | `3` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | n/a | <pre>list(object({<br/>    priority   = number<br/>    region_id  = string<br/>    type       = string<br/>    value      = string<br/>    value_type = number<br/>  }))</pre> | <pre>[<br/>  {<br/>    "priority": 100,<br/>    "region_id": "cn-hangzhou",<br/>    "type": "A",<br/>    "value": "127.0.10.11",<br/>    "value_type": 3<br/>  },<br/>  {<br/>    "priority": 50,<br/>    "region_id": "cn-hangzhou",<br/>    "type": "A",<br/>    "value": "127.0.10.12",<br/>    "value_type": 1<br/>  }<br/>]</pre> | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Anti DDoS traffic scheduler configuration](https://help.aliyun.com/document_detail/2536225.html) 

<!-- docs-link --> 
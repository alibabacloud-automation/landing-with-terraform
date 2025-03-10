## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上使用事件总线EventBridge将事件的状态变更投递到函数计算，涉及到在事件总线中定义规则。
详情可查看[通过Terraform实现IaC自动化部署事件总线，事件发送至函数计算](https://help.aliyun.com/document_detail/424947.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to use EventBridge and send event to Function Compute on Alibaba Cloud, which involves creation of EventBridge rules.
More details in [EventBridge event send to Function Compute](https://help.aliyun.com/document_detail/424947.html).
<!-- DOCS_DESCRIPTION_EN -->

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_event_bridge_event_bus.demo_event_bus](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/event_bridge_event_bus) | resource |
| [alicloud_event_bridge_event_source.demo_event_source](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/event_bridge_event_source) | resource |
| [alicloud_event_bridge_rule.demo_rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/event_bridge_rule) | resource |
| [alicloud_fc_function.fc_function](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/fc_function) | resource |
| [alicloud_fc_service.fc_service](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/fc_service) | resource |
| [alicloud_oss_bucket.code_bucket](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket) | resource |
| [alicloud_oss_bucket_object.function_code](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket_object) | resource |
| [local_file.python_script](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [random_string.random_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [alicloud_caller_identity.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/caller_identity) | data source |
| [archive_file.code](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | 定义变量 | `string` | `"cn-shenzhen"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [EventBridge event send to Function Compute](https://help.aliyun.com/document_detail/424947.html) 

<!-- docs-link --> 
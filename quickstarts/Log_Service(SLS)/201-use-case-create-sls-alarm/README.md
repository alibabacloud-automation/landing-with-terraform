## Introduction

<!-- DOCS_DESCRIPTION_CN -->
本示例用于在阿里云上创建日志服务告警，涉及到SLS项目，日志库，告警规则等资源的创建。
详情可查看[通过Terraform创建SLS告警](https://help.aliyun.com/document_detail/460336.html)。
<!-- DOCS_DESCRIPTION_CN -->

<!-- DOCS_DESCRIPTION_EN -->
This example is used to create SLS alert on Alibaba Cloud, which involves the creation of resources such as SLS project, logstore and alert.
More details in [Create SLS alarm](https://help.aliyun.com/document_detail/460336.html).
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
| [alicloud_log_alert.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_alert) | resource |
| [alicloud_log_project.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_project) | resource |
| [alicloud_log_store.example](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_store) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_email_list"></a> [email\_list](#input\_email\_list) | 告警发出后的通知对象 | `list(string)` | <pre>[<br/>  "ali***@alibaba-inc.com",<br/>  "tf-example@123.com"<br/>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"cn-hangzhou"` | no |
<!-- END_TF_DOCS -->

## Documentation
<!-- docs-link --> 

The template is based on Aliyun document: [Create SLS alarm](https://help.aliyun.com/document_detail/460336.html) 

<!-- docs-link --> 